---
inclusion: fileMatch
fileMatchPattern: ["**/*.test.ts", "**/*.test.tsx", "**/*.test.js", "**/*.test.jsx"]
---

# Testing Guidelines (Jest)

## Rules

1. Only one `expect` per `it` block.

2. Follow the **given / when / then** pattern using nested `describe` and `it` blocks:
   - `describe('given ...')` — setup and context
   - `describe('when ...')` — action under test
   - `it('should ...')` — single assertion (then)

   ```typescript
   describe('given [context A]', () => {
     // setup A
     describe('given [context B]', () => {
       // setup B (depends on A)
       describe('when [action]', () => {
         // invoke
         it('should [outcome]', () => {
           expect(result).toBe(expected);
         });
       });
     });
   });
   ```

3. Each distinct setup concern gets its own nested `describe('given ...')` block. Don't combine unrelated setup in one block.

4. For async functions examined in multiple `it` blocks, assign the promise to a `const` in the `describe` scope and `await` it in each `it`:
   ```typescript
   describe('when [action]', () => {
     const result = asyncFn(args); // promise assigned once

     it('should [X]', async () => {
       expect((await result).x).toBe(expected);
     });
   });
   ```

5. In `describe`/`it` strings, use actual parameter values — not variable names.

## Example

Bad:
```typescript
describe('getUser', () => {
  it('returns user correctly', async () => {
    const result = await getUser('123');
    expect(result.statusCode).toBe(200);
    expect(result.body).toContain('name');
  });
});
```

Good:
```typescript
describe('given user id "123"', () => {
  const userId = '123';

  describe('when getUser("123")', () => {
    const result = getUser(userId);

    it('should return 200', async () => {
      expect((await result).statusCode).toBe(200);
    });

    it('should return name in body', async () => {
      expect((await result).body).toContain('name');
    });
  });
});
```

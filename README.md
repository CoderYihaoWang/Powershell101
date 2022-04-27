# Powershell 101

## Goal

Create a GitHub issue viewer that fetches the issues in the [OctopusDeploy/Issues](https://github.com/OctopusDeploy/Issues) repository.

Requirements:

- Create a function `Get-Issues` that returns an array of issues.
- The returned issues should contain these fields: `Number`, `Title`, `Labels`, `State`, `Created`, `Updated` and `Closed`.
- Use the [GitHub issues API](https://docs.github.com/en/rest/issues/issues) for retrieving the issues.
- The API is paginated. The issue viewer should show the first _n_ pages of results, where _n_ is controlled by a parameter `MaxPages` (default to 3). That is, `Get-Issues -MaxPages 5` should get the first 5 pages.
- Once the issue viewer is working, use it in powershell to:
    1. Display all fetched issues in tables, with `Number` and `Title` as the columns;
    2. Display all opening issues, sorted by the issue number in ascending order;
    3. Display all closed issues in descending order of the close time;
    4. Display all closed issues in descending order of the time taken to close that issue.
    5. For all issues that has a `team/xxx` label, show which team it is triaged to.

## Completed Code

[**Spoiler Alert**] [IssueViewer.ps1](./IssueViewer.ps1)*

*_Only visible in the `solutions` branch_

## Recap

- Cmdlets
    - Cmdlets are a key element of Powershell. 
    - The name of cmdlets follows the convention of `Verb-Noun`.
    - A cmdlet performs an action and possibly returns an object.
    - We can pass the returned object to the next cmdlet using the `|` operator.
    - Use `Get-Command` to list all available cmdlets.
    - Use `Get-Help` to show the documentation for a cmdlet.
    - Use `Get-Member` to inspect the structure of a returned object.
- Syntax
    - Powershell has a similar syntax with most other languages, with some nuances.
    - Use keyword `function` to declare a function.
    - Use `param ( )` block with `[CmdletBinding()]` attribute to create functions that can be invoked as cmdlets.
    - Use `@( )` to declare an array.
    - Use `@{ }` to declare a dictionary.
    - Use `-eq`, `-lt`, `-gt` and so on instead of `=`, `<` and `>` operators.
- Common Cmdlets
    - Use `Invoke-WebRequest` to send http requests.
    - Use `ConvertFrom-Json` to parse a JSON string to a PSObject.
    - Use `ForEach-Object` to iterate through an array.
    - Use `Where-Object` to filter an array.
    - Use `Select-Object` to map one array to another.
    - Use `Sort-Object` to sort an array.

## Challanges

1. Extend the cmdlet to take a parameter `Repo`, so it can work with other repositories.
2. Currently we need to run the .ps1 file to invoke the `Get-Issues` cmdlet. Change the code to a Powershell module and make it automatically loaded when Powershell starts, so that we can call this cmdlet in the same way as the built-in ones. [hint](https://www.improvescripting.com/how-to-create-custom-powershell-cmdlet-step-by-step/)
3. Add a parameter `AllPages` of the type `switch`. When it is present, fetch issues in all pages. [hint](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_functions_advanced_parameters?view=powershell-7.2#switch-parameters)
4. Display a progress bar when fetching the pages, showing the user how many pages have been completed. [hint](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.utility/write-progress?view=powershell-7.2) 
5. Persist the results in a local file, and use it as a cache. [hint](https://docs.microsoft.com/en-us/powershell/scripting/samples/working-with-files-and-folders?view=powershell-7.2)
6. Support searching. [hint](https://docs.github.com/en/rest/search#search-issues-and-pull-requests)
7. Add authentication mechanism so it can work with private repos. [hint](https://docs.github.com/en/rest/guides/basics-of-authentication)

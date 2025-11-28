# Contributing to VLC Spectre

Thank you for your interest in contributing to VLC Spectre! This document provides guidelines for contributing to the project.

## 🤝 How to Contribute

### Reporting Bugs

If you find a bug, please open an issue with:
- Clear description of the problem
- Steps to reproduce
- Expected vs actual behavior
- VLC version and OS information
- Relevant log files (spectre_debug.log)

### Suggesting Features

Feature requests are welcome! Please include:
- Clear description of the feature
- Use case and benefits
- Potential implementation approach (if applicable)

### Submitting Pull Requests

1. **Fork the repository**
2. **Create a feature branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```
3. **Make your changes**
4. **Test thoroughly**
5. **Commit with clear messages**
   ```bash
   git commit -m "Add: Description of your changes"
   ```
6. **Push to your fork**
   ```bash
   git push origin feature/your-feature-name
   ```
7. **Open a Pull Request**

## 📝 Code Style

### Lua Scripts
- Use 4 spaces for indentation
- Add comments for complex logic
- Follow existing naming conventions
- Include error handling with `pcall()`

### XML (Skin Files)
- Use 2 spaces for indentation
- Keep attributes on same line when possible
- Add comments for major sections
- Follow VLC Skins2 DTD specifications

### Documentation
- Use Markdown format
- Keep lines under 100 characters
- Include code examples where helpful
- Update README.md if adding features

## 🧪 Testing

Before submitting:
- Test with VLC 3.0.21
- Verify skin loads correctly
- Check extension activates
- Test on Windows (primary platform)
- Review log output for errors

## 📋 Areas for Contribution

### High Priority
- [ ] Cross-platform support (Linux, macOS)
- [ ] Additional skin themes
- [ ] Improved error handling
- [ ] Performance optimizations

### Medium Priority
- [ ] More scare event types
- [ ] Configurable UI for settings
- [ ] Additional API integrations
- [ ] Localization support

### Low Priority
- [ ] Alternative color schemes
- [ ] Sound effect variations
- [ ] Animation effects
- [ ] Statistics tracking

## 🔍 Code Review Process

1. Maintainers will review your PR
2. Feedback may be provided for changes
3. Once approved, PR will be merged
4. Your contribution will be credited

## 📜 License

By contributing, you agree that your contributions will be licensed under GPL-2.0, matching the project license.

## 💬 Communication

- **Issues**: For bugs and feature requests
- **Pull Requests**: For code contributions
- **Discussions**: For questions and ideas

## 🙏 Recognition

Contributors will be acknowledged in:
- README.md credits section
- Release notes
- Project documentation

Thank you for helping make VLC Spectre better! 🎭

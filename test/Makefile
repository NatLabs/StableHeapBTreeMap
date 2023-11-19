default:
	for file in *Test.mo; do \
		$(shell mocv bin)/moc $(shell mops sources) -wasi-system-api -o TestA.wasm "$$file" && wasmtime TestA.wasm && rm -f TestA.wasm; \
	done

rand:
	node randomIndices.js

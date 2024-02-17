import React, { Fragment } from 'react';

const GridItem = () => {
    // rounded-lg border-0
    const baseBorderStyle = `
        border-slate-200 outline-offset-4 
        bg-slate-400 hover:bg-slate-500
        `;
        
    return (
        <div className={baseBorderStyle}>
            ITEM
            {/* <div class="font-sans text-4xl font-medium text-center">{"<Item />"}</div> */}
        </div>
    )
}

const Header = () => {
    return (
        <div className='pl-5'>
            <p className='font-medium text-white'> Home</p>
        </div>
    );
}

const Home = () => {
    const itemCount = 60
    const itemList = Array(itemCount).fill(<GridItem />)

    return (
        <div className="max-w-[80vh] mx-auto mt-24">
            <div className="grid grid-cols-3 grid-rows-12 min-h-[60vh]">
                <div className='mb-1 rounded-l-lg col-span-3 row-start-1 row-span-1 bg-slate-800 flex justify-left items-center'>
                    <Header />
                </div>
                <div className='mb-1 rounded-r-lg col-start-4 col-span-2 row-start-1 row-span-1 bg-slate-800 flex justify-center items-center'>
                    <p className='font-medium text-white'> Clock </p>
                </div>
                <div className='mr-1 rounded-lg col-span-3 row-start-2 row-span-10 bg-slate-800 flex justify-center items-center'>
                    <p className='font-medium text-4xl text-white'> List </p>
                </div>
                <div className='ml-1 rounded-t-lg col-start-4 col-span-2 row-start-2 row-span-6 bg-slate-800 flex justify-center items-center'>
                    <p className='font-medium text-4xl text-white'> Ingoing Form </p>
                </div>
                <div className='ml-1 rounded-b-lg col-start-4 col-span-2 row-start-8 row-span-4 bg-slate-800 flex justify-center items-center'>
                    <p className='font-medium text-4xl text-white'> Outgoing Form </p>
                </div>
                {/* { itemList } */}
            </div>
        </div>
    )
}

export default Home

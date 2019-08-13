Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 002E98B5D7
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Aug 2019 12:45:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfHMKp4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Aug 2019 06:45:56 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:32998 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727429AbfHMKp4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 13 Aug 2019 06:45:56 -0400
Received: by mail-pf1-f194.google.com with SMTP id g2so51386593pfq.0
        for <linux-ext4@vger.kernel.org>; Tue, 13 Aug 2019 03:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jjB206979c1t5Aiv5jH/wcWJCEjp+cFnx77OyeBUdZ0=;
        b=d/gIWMLwwoUXaYpb/E6DOn4+TE5wubW1b25dOF+D/LiXdjIkbRx2vNN2BGxhSD5rL8
         4T0cA05T1v2js/5jxD9Vi1JLzusSN9SpFnUO0fh9PakAmaugfWfikdQNuu/MYZs/1pKy
         m1RKflCXcnVSGb8x/SvQ3ijSxGD8ddn+q4zvQkIVpv+/g3HET3Q0K6QPmbsrUnrsqU/s
         vZtwJr/bhAAXpcBYTKfLi0DSubYnZ99FzFa4AtMWrC9Uak8zWDFrmXTuRAtakhjoitPm
         1WQSETa05RULq0o1GN/14CRq9AVS+2kAKeoBPotzlvxtPCvfDOmI6jhddVjON1Zl4uYk
         213w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=jjB206979c1t5Aiv5jH/wcWJCEjp+cFnx77OyeBUdZ0=;
        b=rf+ZQS+Q1dk6xTBF86AkKb9Vi8YKPzeV88inYCV6j9L2cZXJMQymKyQ5ILmU27+E33
         qXBeuSoxMWVR5cLztxhjZ0Q1FMv/ZsF+Z/n3LrtLIDes7k+CmUul2iCZg3HR+4ajU2Ko
         7V4qMrYtQKx2ZLkPBB0KfIBsogLpOyr8CLsq3k0CNZsd6ErB/M4/w6WmoKN0ZMiZ8zqj
         DcRCGavza6IPEZeUy91u7gmgTgUgfzsAkNKqmPFf1EuPoRZCrAr0CU/oqWhB/lVO7Cuf
         I+JGv7ArbOGzBDIzRDpAczicjrIUPTkYXR16x8/dQqR4x4Lz3njQte+Byg/v5V9/WBi/
         y7yw==
X-Gm-Message-State: APjAAAX5QZhzy8lNklpvgIkeZy60jT7AOLAaa7B/YSAeGWVx6dU1MkZA
        HoHkwoaLCM/mU2lWA7RV35Ek
X-Google-Smtp-Source: APXvYqw4SvISEThlCjbF61Z2zS+kLF1EdZzOvpY7clRHqJ4wIijDRLCNfmhNB3UIIEKr1AevOm/XCQ==
X-Received: by 2002:a17:90a:800a:: with SMTP id b10mr1566111pjn.23.1565693155216;
        Tue, 13 Aug 2019 03:45:55 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id w129sm9904080pfd.89.2019.08.13.03.45.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 13 Aug 2019 03:45:54 -0700 (PDT)
Date:   Tue, 13 Aug 2019 20:45:48 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu,
        riteshh@linux.ibm.com
Subject: Re: [PATCH 1/5] ext4: introduce direct IO read code path using iomap
 infrastructure
Message-ID: <20190813104547.GA3911@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <3e83a70c4442c6aeb15b7913c39f853e7386a3c3.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812171835.GB24564@infradead.org>
 <20190812201735.GA5307@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190812201735.GA5307@bombadil.infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 12, 2019 at 01:17:35PM -0700, Matthew Wilcox wrote:
> On Mon, Aug 12, 2019 at 10:18:35AM -0700, Christoph Hellwig wrote:
> > >  		return -EIO;
> > >  
> > >  	if (!iov_iter_count(to))
> > >  		return 0; /* skip atime */
> > >  
> > >  #ifdef CONFIG_FS_DAX
> > > -	if (IS_DAX(file_inode(iocb->ki_filp)))
> > > +	if (IS_DAX(inode))
> > >  		return ext4_dax_read_iter(iocb, to);
> > >  #endif
> > 
> > Same here.
> 
> It doesn't even need IS_ENABLED.
> 
> include/linux/fs.h:#define IS_DAX(inode)                ((inode)->i_flags & S_DAX)
> 
> #ifdef CONFIG_FS_DAX
> #define S_DAX           8192    /* Direct Access, avoiding the page cache */
> #else
> #define S_DAX           0       /* Make all the DAX code disappear */
> #endif

Ah, clever - I like it! I actually didn't see this and thank you for
highlighting. I guess I will be dropping the CONFIG_FS_DAX statement
here...

--M


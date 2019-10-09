Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91350D0D39
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Oct 2019 12:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730822AbfJIKzR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Oct 2019 06:55:17 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39865 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729942AbfJIKzR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Oct 2019 06:55:17 -0400
Received: by mail-pl1-f194.google.com with SMTP id s17so875018plp.6
        for <linux-ext4@vger.kernel.org>; Wed, 09 Oct 2019 03:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+CnptUbCiqwsnIpJb3D2CT2yMS6dvy56zGweSq4cKMo=;
        b=WveLTCp96WVtu5P2PQJnEdzGIE/hPPs/jDt1PGNoPYvhEP2wuN3kC3NjzoAhCy0qzi
         v2deOsjEHRJjPrWnCQPCjcthLwDjE64qYXJwIOybe0v/CcX+XfpdcGll5keADfdO6J3T
         xxe8N6Iw94m3zXNZEIuHZHmihq6RHAyOnPTi0yvY1TvAFvxml/vAhGjJ/nbQ4yovwsFi
         eEldE4EmlyKmHZpj6w8OfXm86ujtsW8RCG8Zd2Zv4urIAJPGj2sglKl/O80O41xaxv/S
         gb2biu+cKcbJpzliD+J9EKJIWQvraKJAaP2EWcw51/CVNBNaE0IvERCl0M/t18sPKc4K
         wbWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+CnptUbCiqwsnIpJb3D2CT2yMS6dvy56zGweSq4cKMo=;
        b=nec/XHJAjeCaBioibx/Nf2nwPDL3XiWQqTEO8Dzb9xaXMV0r8ZZSZX6qoIeqs+4Vqe
         R7ekTafbHr3mAIkx8xnLbXdLC+5JkC2AetzHegpWt5M3tyARXMmt3oSDvRdmyqa/2sWl
         tRzquBJb3WOLBur8oSMtArcPMhTomFKDfp4GlVwF/2Oe95q0K6WuSHKhyvOPWyHJsGd8
         q0TSpAt4RQXPcxD/vvNs2w6p8KrvRE2XM7fB2ZttiE5h3r93x5VorXvodH2TB0NX46cc
         iTvIsBA5iUKItBqjfINuCrgkayrKL3ZwwAdlItwyCD9yVMdig2x8YDbQ09Yw3tik2uIm
         K4GQ==
X-Gm-Message-State: APjAAAWwAiJOMS6WweVxEfzEHdQ+tHDC6Eh5ZH/ANimS7hQSlVmcZO3O
        iKxg7r+puGvjeiZQpyqM/j8Q
X-Google-Smtp-Source: APXvYqyRViXujCm+rT1OA6C+7uT71tJQgPtdp0iJBrLQ1wc8AqPBnCiQ/atfCI0eK7laicS22So60w==
X-Received: by 2002:a17:902:690c:: with SMTP id j12mr2407509plk.183.1570618516281;
        Wed, 09 Oct 2019 03:55:16 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id r18sm3307569pfc.3.2019.10.09.03.55.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 03:55:15 -0700 (PDT)
Date:   Wed, 9 Oct 2019 21:55:09 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        hch@infradead.org, david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v4 4/8] ext4: introduce direct I/O read path using iomap
 infrastructure
Message-ID: <20191009105507.GF14749@poseidon.bobrowski.net>
References: <cover.1570100361.git.mbobrowski@mbobrowski.org>
 <df2b8a10641ec8a0509f137dcc2db1d3cc6087f1.1570100361.git.mbobrowski@mbobrowski.org>
 <20191008105207.GG5078@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191008105207.GG5078@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Oct 08, 2019 at 12:52:07PM +0200, Jan Kara wrote:
> On Thu 03-10-19 21:34:00, Matthew Bobrowski wrote:
> > This patch introduces a new direct I/O read path that makes use of the
> > iomap infrastructure.
> > 
> > The new function ext4_dio_read_iter() is responsible for calling into
> > the iomap infrastructure via iomap_dio_rw(). If the read operation
> > being performed on the inode does not pass the preliminary checks
> > performed within ext4_dio_supported(), then we simply fallback to
> > buffered I/O in order to fulfil the request.
> > 
> > Existing direct I/O read buffer_head code has been removed as it's now
> > redundant.
> > 
> > Signed-off-by: Matthew Bobrowski <mbobrowski@mbobrowski.org>
> 
> The patch looks good to me. Just one small nit below. With that fixed, you
> can add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>

Cool, I'll fix it!

> > +	/*
> > +	 * Get exclusion from truncate and other inode operations.
> > +	 */
> > +	if (!inode_trylock_shared(inode)) {
> > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > +			return -EAGAIN;
> > +		inode_lock_shared(inode);
> > +	}
> 
> I've noticed here you actually introduce new trylock pattern - previously
> we had unconditional inode_lock_shared() in ext4_direct_IO_read(). So the
> cleanest would be to just use unconditional inode_lock_shared() here and
> then fixup IOCB_NOWAIT handling (I agree that was missing in the original
> code) in a separate patch.

Right, so I will just have an unconditional call to
inode_lock_shared() and in the patch that follows I will fix it up to
apply the new pattern.

> And the pattern should rather look like:
>
> 	if (iocb->ki_flags & IOCB_NOWAIT) {
> 		if (!inode_trylock_shared(inode))
> 			return -EAGAIN;
> 	} else {
> 		inode_lock_shared(inode);
> 	}
> 
> to avoid two atomical operations instead of one in the fast path. No need
> to repeat old mistakes when we know better :).

Yes, also agree.

--<M>--

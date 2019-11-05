Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECC5F0766
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 21:57:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729913AbfKEU5Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 15:57:24 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40763 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729888AbfKEU5X (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Nov 2019 15:57:23 -0500
Received: by mail-pg1-f196.google.com with SMTP id 15so15315620pgt.7
        for <linux-ext4@vger.kernel.org>; Tue, 05 Nov 2019 12:57:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ldGXgXo+SDJcu05JI5sP7Qx9Oq7c4XpgCQT7FyWcujU=;
        b=gHiIFbFcG1vYdm3LeRDPMt7Y4tNkBMDPYHtXOmAxUNCYSu0hFXWYUwTs8OKze3e3Fg
         lgGrQadPjBlnzheU7mrduN8WzUNA/5EKDZSsKM8Ub23Gs5qtl1CjaaJMrldSNV0egQC1
         IbdijKI26mRr5TgpPXqc9WhLl7/0/n3xjpChRrHtbp3Gj7d2gFbZy2O4ppWnHCGxPfe2
         dx8DFB+9sEeH7Kn5CyQmzps4mLv8Vp5/7f/uXZseVRJbOCOwnW2y+jpmwFhNhNGfTv8Y
         Ycv+tg3lrotJYfwqvFF2yybRziV9qiK1nLSAwi0/Hl11239VOyc5+2HWHslH4LSee50Q
         G0Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=ldGXgXo+SDJcu05JI5sP7Qx9Oq7c4XpgCQT7FyWcujU=;
        b=PvnKPvAfa8fsspNplgT+6/HxPu2oDa08MeXa2sXq0ueIPUBtPxWlFQVFpy7Xk1nYpj
         otxpHHJ1cWaaqOtXVA4KvPOwgAifOaz4yWE9ubRxIParY8xxp5QbdS9Mn4FCRCmtD2jF
         g2x4agV2XU4ergQtgKWUho2mfFdcLb3LtlrTAVocsVU+VOIcn3hLEiTWw4OtaTfwD25r
         s9pUtzfqqDjznxbqn5UHKhRYz56jDoVXy8IOk9ywAC08BoWasFQKIYLA1+44y0KobpRi
         pSQk1jPbzmQ5Bhe94+I/09WDn/WwIZWR7XDMXgBIXa6SweUYuoES+qyM6fUsE9XtgQUi
         QlmQ==
X-Gm-Message-State: APjAAAUM7o6YY6+2CWGVT68JaJDI5K5ltR06xAqFChOZt5H0SZy/hfcT
        GuRNgyMhsuMoNtxTz2OreWQ2
X-Google-Smtp-Source: APXvYqyZvZ8z6aFDo9V/anMBANv/lQpc6y2kSRxPvaQXaod+0XH/zrAGuX3zmXIxOV/sGOZXu13vvA==
X-Received: by 2002:a17:90a:f0cf:: with SMTP id fa15mr1318583pjb.51.1572987440647;
        Tue, 05 Nov 2019 12:57:20 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id z11sm26264279pfg.117.2019.11.05.12.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2019 12:57:19 -0800 (PST)
Date:   Wed, 6 Nov 2019 07:57:13 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, riteshh@linux.ibm.com
Subject: Re: [PATCH v7 11/11] ext4: introduce direct I/O write using iomap
 infrastructure
Message-ID: <20191105205712.GB1739@bobrowski>
References: <cover.1572949325.git.mbobrowski@mbobrowski.org>
 <e55db6f12ae6ff017f36774135e79f3e7b0333da.1572949325.git.mbobrowski@mbobrowski.org>
 <20191105162855.GK28764@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191105162855.GK28764@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 05, 2019 at 11:28:55AM -0500, Theodore Y. Ts'o wrote:
> On Tue, Nov 05, 2019 at 11:02:39PM +1100, Matthew Bobrowski wrote:
> > +	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> > +			   is_sync_kiocb(iocb) || unaligned_aio || extend);
> > +
> > +	if (extend)
> > +		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> > +
> 
> Can we do a slight optimization here like this?
> 
> 	ret = iomap_dio_rw(iocb, from, &ext4_iomap_ops, &ext4_dio_write_ops,
> 			   is_sync_kiocb(iocb) || unaligned_aio || extend);
> 
> 	if (extend && ret != -EBIOCQUEUED)
> 		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> 
> 
> If iomap_dio_rw() returns -EBIOCQUEUED, there's no need to do any of
> the ext4_handle_inode_extension --- in particular, there's no need to
> call ext4_truncate_failed_write(), which has a bunch of extra
> overhead, including taking and releasing i_data_sem.

Hm, but for extension, unaligned asynchronous IO, or synchronous IO
cases, 'wait_for_completion' within iomap_dio_rw() is set to true and
as a result we'd never expect to receive -EIOCBQUEUED from
iomap_dio_rw()?

So, with that said, would the above change be necessary seeing as
though we'd never expect ret == -EIOCBQUEUED when extend == true?

Maybe I'm missing something?

/M


Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 006FCB4DEC
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Sep 2019 14:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbfIQMjJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Sep 2019 08:39:09 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:35688 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727112AbfIQMjJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Sep 2019 08:39:09 -0400
Received: by mail-pf1-f195.google.com with SMTP id 205so2113103pfw.2
        for <linux-ext4@vger.kernel.org>; Tue, 17 Sep 2019 05:39:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OTvLvWZQKYamARFFGSiOc5HaM2nlxTYOTsAuTJxrrZs=;
        b=ciD6VU9yB23JT/INsw0iZBKrcCvl4Dhneq7SKh0gol9MakWQxeEtxuLaARa/b/TRvZ
         W85vqr3GqAujOQ9vB9o2sxjiyEfp1l3GZ3a+7MIlEGRzaRRXK0w1ZGEQLc2iQ/rMGcrl
         i/AeSvz4KkpdR3CyEN/fVlZ4I4h/kRJrlVzdilVlupwyA1BSVzqDav4VIa+i6GnevFUX
         kkMw44kDLSsGB79HdHYR7mH8enAE3X7GUC8g/JA+bP+1D0C+x5UqRL8ufkTtrLMcY0dG
         RAFK27B/7zODPALJLjGWPi3Qw5kKJGs6x6Q8JGEXG4weltt/7kG/Q4kfwNYh1qRkrzdx
         Z5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OTvLvWZQKYamARFFGSiOc5HaM2nlxTYOTsAuTJxrrZs=;
        b=jyjQP2q9uEu3i0zPOTlN9DpZGnLyu8zKMxkH5wv/0DgtgO32PunCdMFuQ4ZhCFMBUT
         ew2CovurHLB11CUvOSpDN1uPUi1sg86R/0jugTaekCM5Ojpyc0QNGGA8/jCA9QSID5RX
         6b4mV2csNqfTgg3T3aRbHXuAxgx2EG8PJUadRzQYXi0Hkm8wzd5KQqk3rIRH/HNxADZe
         O+o5GGzD7X9PacU/lhyr8zAoCf8q8ZIfoLwFXkE9wDQVQYlkqulfVJ3Un1fep/aYMsPU
         kjMM/e4tmMLOpUfwL6C9WlO9iN6i+gJhxXZ43XxVWtb924iaJ3cTibE4gdt+Bt0rtJcW
         6VJQ==
X-Gm-Message-State: APjAAAUJ4Uur9Rf4Qj8M9zxGmjRDx225ZP7bFYiuSMdXLaD9CkI3a9E4
        zSCcXM/R+NV4FdmK5u+Wd3au
X-Google-Smtp-Source: APXvYqxHGql6gtXiSLgnubOsn1tuxwk2FA+6A4sN+VnBtelTx82oAS/kvGo08+sSLohyfTC2EAHG7g==
X-Received: by 2002:a62:7a12:: with SMTP id v18mr4037934pfc.205.1568723948525;
        Tue, 17 Sep 2019 05:39:08 -0700 (PDT)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id 2sm2758518pfa.43.2019.09.17.05.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Sep 2019 05:39:07 -0700 (PDT)
Date:   Tue, 17 Sep 2019 22:39:01 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Ritesh Harjani <riteshh@linux.ibm.com>, tytso@mit.edu,
        jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com,
        darrick.wong@oracle.com
Subject: Re: [PATCH v3 5/6] ext4: introduce direct IO write path using iomap
 infrastructure
Message-ID: <20190917123901.GB17286@bobrowski>
References: <cover.1568282664.git.mbobrowski@mbobrowski.org>
 <db33705f9ba35ccbe20fc19b8ecbbf2078beff08.1568282664.git.mbobrowski@mbobrowski.org>
 <20190916121248.GD4005@infradead.org>
 <20190916223741.GA5936@bobrowski>
 <20190917090016.266CB520A1@d06av21.portsmouth.uk.ibm.com>
 <20190917090233.GB29487@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190917090233.GB29487@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 17, 2019 at 02:02:33AM -0700, Christoph Hellwig wrote:
> On Tue, Sep 17, 2019 at 02:30:15PM +0530, Ritesh Harjani wrote:
> > So if we have a delayed buffered write to a file,
> > in that case we first only update inode->i_size and update
> > i_disksize at writeback time
> > (i.e. during block allocation).
> > In that case when we call for ext4_dio_write_iter
> > since offset + len > i_disksize, we call for ext4_update_i_disksize().
> > 
> > Now if writeback for some reason failed. And the system crashes, during the
> > DIO writes, after the blocks are allocated. Then during reboot we may have
> > an inconsistent inode, since we did not add the inode into the
> > orphan list before we updated the inode->i_disksize. And journal replay
> > may not succeed.
> > 
> > 1. Can above actually happen? I am still not able to figure out the
> >    race/inconsistency completely.
> > 2. Can you please help explain under what other cases
> >    it was necessary to call ext4_update_i_disksize() in DIO write paths?
> > 3. When will i_disksize be out-of-sync with i_size during DIO writes?
> 
> None of the above seems new in this patchset, does it?

That's correct.

*Ritesh - FWIW, I think you'll find the answers to your questions above by
 referring to the following commits:

 1) 73fdad00b208b
 2) 45d8ec4d9fd54

If you drop the check (offset + count > EXT4_I(inode)->i_disksize) and the
call to ext4_update_i_disksize(), under some workloads i.e. "generic/475"
you'll generally end up with metadata corruption.

> That being said I found the early size update odd. XFS updates the on-disk
> size only at I/O completion time to deal with various races including the
> potential exposure of stale data.

Indeed a little odd. But, I think delalloc/writeback implementation is
possibly to blame here (based on what's detailed in 45d8ec4d9fd54)? Ideally, I
had the same approach as XFS in mind, but I couldn't do it.

--<M>--

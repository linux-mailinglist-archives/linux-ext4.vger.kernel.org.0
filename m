Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 732FF8D012
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2019 11:51:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726126AbfHNJvo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Aug 2019 05:51:44 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39147 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbfHNJvo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Aug 2019 05:51:44 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so52818943pgi.6
        for <linux-ext4@vger.kernel.org>; Wed, 14 Aug 2019 02:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=CTjXkNLtIlZdiGswkbUCLARIFPrueo4vLqMjVGjBKEI=;
        b=b5RL7sfRkbMNTwqPF6d0Li/f4oeQ+n+I1sn5Ox5kDeJyvqtk6T8sBALblp+qvhSASV
         BsFpeBzRC6tIld9CGV7c5xVMXxR6ySgOtRZHj8IoxDW9zrR4pFm9dcM7xoda3mXWUrFx
         g7E1kW+9J1UHNnKZTQavOgGO2xavntWTfaIbEtrsRGP3ql3G21zzwS8o8HNt7qxpDosB
         HD7CY770MLktRFNp004HCLNeN8WQhqb/2ImiPZoPeUNUKmBi6uBjFOiPhVfSPrERGLPp
         Tm+dLBjxnq40jwVo16WRXGeJlMyZZkHiOYIchcUUEXQyNAjpGEiyfStY+tSYRWjnaZop
         i3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=CTjXkNLtIlZdiGswkbUCLARIFPrueo4vLqMjVGjBKEI=;
        b=ZTsyBQvNIkSo4W+B048T1hp3gnXAR8RKaN/g8p2AOBQO/K6gt6dVin3EniGrRCMS2i
         J/Dtil8iMfvnoDg7k6jO3S4Ha7/nML28BRPIACQbs+QiXFd7QZcROL2pRW+ZONmtmJLW
         ++UZUZ72eqdM9c/qEPG/AvEHENnQaWLe2QNJCEZA6AD2poD98Uchaa5aary4W5J+4AZE
         cz76I/NQo4WsJal9ZF0V/EcNIQ3FD1ik79CkJvHi/b+RtCongw7Bhf1UbpCZOfkF5oYl
         c3EP2gcwIZgn0MOSKZJkzXMEz+EqCQfiB9jFyJakB+vJfHQNpjruEb+4A2EU6RuZeVjn
         NRfg==
X-Gm-Message-State: APjAAAWxfMMNpyLxRyj2lUzrYWUlmdE8tC7t3NU/cUyUS7/r+uVhfizn
        OhSuOoFL2We2gX3YZ7c1cZA8
X-Google-Smtp-Source: APXvYqz0w3CayWUDos1ksVd7GFUBUzsBYghH49YYobGm5V7YFtDtxM6gJGc5zOnKV+X1yOounAdF+g==
X-Received: by 2002:a65:534c:: with SMTP id w12mr38270582pgr.51.1565776303588;
        Wed, 14 Aug 2019 02:51:43 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id c23sm105833958pgj.62.2019.08.14.02.51.40
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 14 Aug 2019 02:51:42 -0700 (PDT)
Date:   Wed, 14 Aug 2019 19:51:37 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     RITESH HARJANI <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, tytso@mit.edu
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190814095135.GB23465@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190812170430.982E552051@d06av21.portsmouth.uk.ibm.com>
 <20190813125840.GA10187@neo.Home>
 <20190813143540.GA7126@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190813143540.GA7126@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Aug 13, 2019 at 07:35:40AM -0700, Darrick J. Wong wrote:
> On Tue, Aug 13, 2019 at 10:58:42PM +1000, Matthew Bobrowski wrote:
> > On Mon, Aug 12, 2019 at 10:34:29PM +0530, RITESH HARJANI wrote:
> > > > +
> > > > +	if (ret >= 0 && iov_iter_count(from)) {
> > > > +		overwrite ? inode_unlock_shared(inode) : inode_unlock(inode);
> > > > +		return ext4_buffered_write_iter(iocb, from);
> > > > +	}
> > > should not we copy code from "__generic_file_write_iter" which does below?
> > > 
> > > 3436                 /*
> > > 3437                  * We need to ensure that the page cache pages are
> > > written to
> > > 3438                  * disk and invalidated to preserve the expected
> > > O_DIRECT
> > > 3439                  * semantics.
> > > 3440                  */
> > 
> > Hm, I don't see why this would be required seeing as though the page cache
> > invalidation semantics pre and post write are handled by iomap_dio_rw() and
> > iomap_dio_complete(). But, I could be completely wrong here, so we may need to
> > wait for some others to provide comments on this.
> 
> iomap_dio_rw is supposed to zap the page cache before the write and
> again afterwards (and whine if someone is racing buffered and direct
> writes to the same file location), so ext4 shouldn't need to do that
> itself.

Thanks for confirming Darrick! I thought that was the case.

--M

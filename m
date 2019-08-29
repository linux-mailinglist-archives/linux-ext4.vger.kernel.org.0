Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 414F4A1939
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2019 13:47:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbfH2Lrs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Aug 2019 07:47:48 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:37538 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727025AbfH2Lrs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Aug 2019 07:47:48 -0400
Received: by mail-pl1-f196.google.com with SMTP id bj8so1465603plb.4
        for <linux-ext4@vger.kernel.org>; Thu, 29 Aug 2019 04:47:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GJEPwHyOcI+9dLEPiZabTxPmPRqcFsYfFf6j8W16rfw=;
        b=Do9PVhF7XnMVGEyzkcgD1V4MEr0kOY1BTS0PQogGdlpNArgszV7Li4uTixwFTX0B0e
         rz7bLocIOK5pi1fWJU7G2tUI6q9EYLbgiQkhwL7YhjYYZDoCAnnAdezrIbTL+ywgsojO
         XIioUS5nl3xf4ACNOjrkTSQJKdApent1GnNNmvCg2Zvg3U4joWVuDb1jclxwJpg4kkJv
         5aSxhmukG9pD7VvTWEXb9qrF8DAE4jpdHsnfYw83piGwg8+znU/sCfPjxlrhGSnVRsd1
         B4ICe535ezIk5MRRvVullgUENVe81buiPzGyRNV/wVKCXT3izPsrIMk1FMct5oTvoxeQ
         PKxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GJEPwHyOcI+9dLEPiZabTxPmPRqcFsYfFf6j8W16rfw=;
        b=euA4iofaDt3b5dg4meN8/X8gW+ScCTCI2iofVcW6HvVEEqrM7xQSc46/V37qYy3Ebs
         N/3vtBn6OzHC20OWWgwll1ApcdsVlESgruYc34PgBNJMnAAPMWPaLrvHjJiJrqGZj3lG
         n/iwhnMO5cXNv9eNlIqmjhi98y1gUKH8yS8BAhKLegGnyx81GLY6/nOawNEDLBslGNv3
         c58lqnf2Rd+c4lERWHXnjk33iVfo0C+ZiuJ8XwJap7oVCK7f51zQqhL/qPenlQmcudGo
         POMoLElCrMj68bSJaMK479VU6rc4byoqAZDiNC8n+qwq9uq3S6Jhlhlg+6a0XCeUcH7I
         Th6A==
X-Gm-Message-State: APjAAAVgiY72LziFKTn0GI75rafbiEkeguk7gmNnL6aprpbHEaPz6XPb
        KtfJuJXRO7ZhZXB0nFoLzMv0
X-Google-Smtp-Source: APXvYqxy2YKWkWFfGKTMt2jffl5EV3jl3XWiD1TU9NPDdRtyU6Ua+uySGZA5Njp1Zj11WaK7T1p65A==
X-Received: by 2002:a17:902:7892:: with SMTP id q18mr9016585pll.206.1567079267436;
        Thu, 29 Aug 2019 04:47:47 -0700 (PDT)
Received: from poseidon.bobrowski.net ([114.78.226.167])
        by smtp.gmail.com with ESMTPSA id b18sm3137286pfi.160.2019.08.29.04.47.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2019 04:47:46 -0700 (PDT)
Date:   Thu, 29 Aug 2019 21:47:41 +1000
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, riteshh@linux.ibm.com
Subject: Re: [PATCH 4/5] ext4: introduce direct IO write code path using
 iomap infrastructure
Message-ID: <20190829114740.GC2486@poseidon.bobrowski.net>
References: <cover.1565609891.git.mbobrowski@mbobrowski.org>
 <581c3a2da89991e7ce5862d93dcfb23e1dc8ddc8.1565609891.git.mbobrowski@mbobrowski.org>
 <20190828202619.GG22343@quack2.suse.cz>
 <20190828223218.GZ7777@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190828223218.GZ7777@dread.disaster.area>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 29, 2019 at 08:32:18AM +1000, Dave Chinner wrote:
> On Wed, Aug 28, 2019 at 10:26:19PM +0200, Jan Kara wrote:
> > On Mon 12-08-19 22:53:26, Matthew Bobrowski wrote:
> > > @@ -235,6 +244,34 @@ static ssize_t ext4_write_checks(struct kiocb *iocb, struct iov_iter *from)
> > >  	return iov_iter_count(from);
> > >  }
> > >  
> > > +static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> > > +					struct iov_iter *from)
> > > +{
> > > +	ssize_t ret;
> > > +	struct inode *inode = file_inode(iocb->ki_filp);
> > > +
> > > +	if (!inode_trylock(inode)) {
> > > +		if (iocb->ki_flags & IOCB_NOWAIT)
> > > +			return -EOPNOTSUPP;
> > > +		inode_lock(inode);
> > > +	}
> > 
> > Currently there's no support for IOCB_NOWAIT for buffered IO so you can
> > replace this with "inode_lock(inode)".
> 
> IOCB_NOWAIT is supported for buffered reads. It is not supported on
> buffered writes (as yet), so this should return EOPNOTSUPP if
> IOCB_NOWAIT is set, regardless of whether the lock can be grabbed or
> not.

Noted! Thank you Dave. ;-)

--M

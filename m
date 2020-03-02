Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC5C175435
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Mar 2020 08:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgCBHE0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Mar 2020 02:04:26 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38565 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCBHE0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Mar 2020 02:04:26 -0500
Received: by mail-pl1-f193.google.com with SMTP id p7so3833214pli.5
        for <linux-ext4@vger.kernel.org>; Sun, 01 Mar 2020 23:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bR+IZGUsjrOq0qMGsXzOsmVidNKiUiSF2awIM19/sBM=;
        b=kNkXk3S3Hywipda1q/hm31vnE8aCFWKYz7Y707Rx+Bx7XbrSB578W1DajlmLaZrClp
         joJjretYM1mugM9/dVgDi14/CIVUqwcfNEjZqPAXJi9/lP9JZj81S1z6paji3rCd8v4C
         OPYAi/qvxQeKR45YaV3nplDazB2xMr9R9tyBCEYMl1jxRIxsXFbVZCbEtn6tAG7nl2H8
         F6nd+hXTvY1ZGcDVdcv/rc9qWTlV2j5Slxgcarq19w62aqhif5GeAJ0AGCz531rnPzAL
         glA9QD04VCDyOIAB1uwpl8MqOdhRv7E/y11gZDhl5Me/4ygxgjKlKr5O+MtDnXTN1MtJ
         9wVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bR+IZGUsjrOq0qMGsXzOsmVidNKiUiSF2awIM19/sBM=;
        b=C6lYda4mlYYKwPcl2UeUeAbc6LJ3LmUQ4MTEOxNHIBuX7wMOOCk5lvPSnwLApKigiC
         g5m0QdJXXYFUmrYtrxjdloYJKk7L7fUd/lT0DOefuoCY81tVninL2oU1DEX5yXSZZur0
         Ac5FrdG36oZpR2WR51Fi/6++DO3u9hzQ16/aM+CKvRGQHNq1B4cZw2CURLz0Pot/tskW
         MgID6l1L9+8zTJxzLguKwrB9V0kAYFT2XC8RYKh8RvXQFlhY+bXQy5Z1DqeRd4+CYMt5
         lV1a/s3EKNuMmHrr1jcfyop0qMhNsRYU2RHcFNEJ/fyQxFvdsWET5psxCYP/OE676DyP
         kaNA==
X-Gm-Message-State: ANhLgQ1oZpTTxP0Wyz7e4uRo+CDw7DAZ6Yd2DRwZu5uv8JO50UjOG37r
        I71h36SN1Q3jx9xX2ZLuGBXBLVpx
X-Google-Smtp-Source: ADFU+vu9TQIw08zvQdqi7fEEnLBzL3AFBXLkCA5F3l/tPAo1SbP2pHXq2Hf0LErThdv9d28RRU6D/w==
X-Received: by 2002:a17:90a:cc15:: with SMTP id b21mr2064615pju.136.1583132665879;
        Sun, 01 Mar 2020 23:04:25 -0800 (PST)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id e4sm15873740pfi.99.2020.03.01.23.04.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:04:25 -0800 (PST)
Date:   Mon, 2 Mar 2020 15:04:17 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: ENOSPC inline_data fsck failure
Message-ID: <20200302070417.ldaoyxenqkixny43@xzhoux.usersys.redhat.com>
References: <20200228105234.n5wt5x2vi3ftxuyh@xzhoux.usersys.redhat.com>
 <20200229181711.GD7378@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200229181711.GD7378@mit.edu>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Feb 29, 2020 at 01:17:11PM -0500, Theodore Y. Ts'o wrote:
> On Fri, Feb 28, 2020 at 06:52:34PM +0800, Murphy Zhou wrote:
> > 
> > With inline_data mkfs option, generic/083 can easily trigger
> > a fsck failure like this:
> > 
> > The testcase is doing a simple testing: make a small(256M) fs,
> > run fsstress in it,  make it out of space. Then fsck.
> > 
> > Not sure about is this an issue of ext4 filesystem or e2fsck
> > needs more options.
> 
> This is an ext4 bug.  It's been on my radar screen to investigate one
> of these days, but I've just never gotten around to it.  I'm guessing
> the bug is the error handling case when an inline directory is getting
> converted directory where its contents are stored in data blocks, and
> the block allocation fails due to the ENOSPC.
> 
> 						- Ted

Thanks Ted for the confirmation!

-- 
Murphy

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC84ED8CF
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2019 07:04:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbfKDGEV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 Nov 2019 01:04:21 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33233 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726248AbfKDGEU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 Nov 2019 01:04:20 -0500
Received: by mail-pf1-f195.google.com with SMTP id c184so11451169pfb.0
        for <linux-ext4@vger.kernel.org>; Sun, 03 Nov 2019 22:04:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mbobrowski-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XvoalgHkeJYVA1m59VqwYPB0jL7bT8NQ3r5ipKUnu84=;
        b=P7vqFsa9ppPiE5gy875KwUB+sQ2UTxUffP2yPRaXvdFQkeEx94zWCWCK1p+edZqzcK
         eE8zPapq3g6RYdTqdzQiD4uavII+WdQHANBeDRblr/u2QfzRp5m/94ag5k3WlMcHXiFc
         zfspgk+TqRKC1s0xuFWVe+Q1/pLlTc5ILwOV4KmzGZnIrJTG99BgGRX3dc6DtyJwNrkg
         AVzXHhQNNfZftFP4xvbMWcAjUpY9K5s5oKwCatwmKDbEjlcPUFAi/bY6YsLMjIdsW8A1
         cBbGwGvw9CAVy/JW+85R58OSiVTp54wzRj+FxQzE809e2b/mZCI6Pe5DRNmCLVCTQHuF
         JAAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XvoalgHkeJYVA1m59VqwYPB0jL7bT8NQ3r5ipKUnu84=;
        b=lAQp3bYX0/QjgnwoqnO4kqOq3b93Y1i2xQaFFa/+CcKx3+HVIuw59iKcCnjN9V5TEc
         4EzUtSirzXt22wjALyTSGy1tPGhXXXmv6yKXwawmyrfOudmOOqR2qWpDRu6uUt56oLDw
         EfnDyiQ2Nf9FHIrRTDdNDgeqCDHKw+COGY5win2gOeflSR/iLuOKwC70TYYiJCkT5ES6
         AnBz2567Z+I79exDZWViPO9mdphj3l30M8gMz1n/+cmA04MDMOP457pmqCKCHevzh8+Z
         KG2wp+6aKWzydzk2gt9hRMYMfkkNj6ZmvTIWRt/gLxNihj7y8kA0KYqPbQOoBwxTYyEB
         Ktrw==
X-Gm-Message-State: APjAAAUt7IVC83Kv0qHcNPpN1/vF2QlEq4juU7xzRizCwj2jUm5CfVrs
        PFTn87CYLO/28joRLo5NkwOn
X-Google-Smtp-Source: APXvYqz2R5pEkootFGm2PTDz5+c3Oder8COlYEVXArETC3svxCgNGukkTYgcruMKwN2fMOYbAhqtRg==
X-Received: by 2002:a63:c411:: with SMTP id h17mr5998304pgd.360.1572847454718;
        Sun, 03 Nov 2019 22:04:14 -0800 (PST)
Received: from bobrowski ([110.232.114.101])
        by smtp.gmail.com with ESMTPSA id t13sm14476121pfh.12.2019.11.03.22.04.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Nov 2019 22:04:14 -0800 (PST)
Date:   Mon, 4 Nov 2019 17:04:07 +1100
From:   Matthew Bobrowski <mbobrowski@mbobrowski.org>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     jack@suse.cz, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, hch@infradead.org,
        david@fromorbit.com, darrick.wong@oracle.com
Subject: Re: [PATCH v6 00/11] ext4: port direct I/O to iomap infrastructure
Message-ID: <20191104060405.GA27115@bobrowski>
References: <cover.1572255424.git.mbobrowski@mbobrowski.org>
 <20191103192040.GA12985@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191103192040.GA12985@mit.edu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Howdy Ted!

On Sun, Nov 03, 2019 at 02:20:40PM -0500, Theodore Y. Ts'o wrote:
> Hi Matthew, could you do me a favor?  For the next (and hopefully
> final :-) spin of this patch series, could you base it on the
> ext4.git's master branch.  Then pull in Darrick's iomap-for-next
> branch, and then apply your patches on top of that.
> 
> I attempted to do this with the v6 patch series --- see the tt/mb-dio
> branch --- and I described on another e-mail thread, I appear to have
> screwed up that patch conflicts, since it's causing a failure with
> diroead-nolock using a 1k block size.  Since this wasn't something
> that worked when you were first working on the patch set, this isn't
> something I'm going to consider blocking, especially since a flay test
> failure which happens 7% of the time, and using dioread_nolock with a
> sub-page blocksize isn't something that is going to be all that common
> (since it wasn't working at all up until now).
> 
> Still, I'm hoping that either Ritesh or you can figure out how my
> simple-minded handling of the patch conflict between your and his
> patch series can be addressed properly.

OK, I will try get around to this tonight. :)

--<M>--

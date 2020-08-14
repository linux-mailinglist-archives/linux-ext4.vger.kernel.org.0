Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E110D244621
	for <lists+linux-ext4@lfdr.de>; Fri, 14 Aug 2020 10:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgHNIGk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 14 Aug 2020 04:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726227AbgHNIGk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 14 Aug 2020 04:06:40 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C11DC061383
        for <linux-ext4@vger.kernel.org>; Fri, 14 Aug 2020 01:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RBq6UiQ6kGgsjOf+4Bi2VfeeyHRI8+V7TFQ6zqhUqq4=; b=NbB0CrFLJk3spwHkOzD/u2LA/N
        1fPCh7KfIbrlZUaAL2dXFnA9NzarP7FOESSr/zB+3ruy67JMInfr9kPRFrjn3kQ6LwU/KhY8kVS3a
        mKBCPTY74txTAwC/GLEYJVqXgCvCNXBMTZGuD87QHGtXfImwTUJ3yqVeH1HBjYpp2g/wZWjK3AjwB
        TZ7X11j9ZU2O25tjar6RUThb+noumDe1V+GIop2uIQBd7IgkE5amfNjITOQ4Y0uR6zigvfQVN8wMY
        3WfN1JF9UjmdFYHgPNWPZxzu8L2R1oFR1iApO8zNw0PGQrn9HOdGHKoannDzsonvDpADx+FWzQYQQ
        3zoeBJrw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k6UjT-00042i-L6; Fri, 14 Aug 2020 08:06:35 +0000
Date:   Fri, 14 Aug 2020 09:06:35 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     tytso@mit.edu
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>, Shuichi Ihara <sihara@ddn.com>
Subject: Re: [PATCH v3 1/2] ext4: introduce EXT4_BG_WAS_TRIMMED to optimize
 trim
Message-ID: <20200814080635.GA14827@infradead.org>
References: <1592831677-13945-1-git-send-email-wangshilong1991@gmail.com>
 <20200806044703.GC7657@mit.edu>
 <CAP9B-Qnv2LXva_szv+sDOiawQ6zRb9a8u-UAsbXqSqWiK+emiQ@mail.gmail.com>
 <20200808151801.GA284779@mit.edu>
 <9789BE11-11FB-42B2-A5BE-D4887838ED10@dilger.ca>
 <20200810132457.GA14208@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200810132457.GA14208@mit.edu>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 10, 2020 at 09:24:57AM -0400, tytso@mit.edu wrote:
> Part of the problem here is that discard is being used for different
> things for different use cases and devices with different discard
> speeds.  Right now, one of the primary uses of -o discard is for
> people who have fast discard implementation(s and/or people who really
> want to make sure every freed block is immediately discard --- perhaps
> to meet security / privacy requirements (such as HIPPA compliance,
> etc.).   I don't want to break that.

Note that discard does not provide any security whatsover.  For one
none of the underlying primitives actually gurantee any action, the
device is free to always ignore parts or all of a discard request.

And even if it didn't that doesn't mean that data couldn't easily
recovered from the media.

> 
> We now have a requirement of people who have very slow discards --- I
> think at one point people mentioned something about for devices using
> HDD, probably in some kind of dm-thin use case?  One solution that we
> can use for those is simply use fstrim -m 8M or some such.  But it
> appears that part of the problem is people do want more precision than
> that?

Device managed SMR drivers usually support TRIM.  But it actually
should be a decently fast operation usually, as those drives have a
remapping layer just like a FTL.

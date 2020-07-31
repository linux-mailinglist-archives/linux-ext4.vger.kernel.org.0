Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9F6233F5A
	for <lists+linux-ext4@lfdr.de>; Fri, 31 Jul 2020 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731379AbgGaGql (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 31 Jul 2020 02:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731359AbgGaGql (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 31 Jul 2020 02:46:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21DD4C061574;
        Thu, 30 Jul 2020 23:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hJZzQxamo8cM63RzvDBAwdcLMgZgDTBqDhShXNpmlY4=; b=f311v+ZfsEzF5qd14z+PRFQ+q9
        /SjeH+xS92JesR3F+yZRkiahlMaYviu8XqaH0vCLQfE/vdmoV1DO0EnZhcQdd9YQR9YzyQPj5fArY
        LHKpMdLbCnm2DtXPQ81Ds//+//M64qbOLwlsa/tSTeiEBDedxfe92QdOpesQlWhILMlnlH6hRMxXa
        jODPLBqHhow047F2fHsAO9RYJmUCdSHBREGdJ9ObUISNAf5SeXBhZ4iSAdKH1Je4ivTFxXDpqDoAG
        bug3rz/k0V5Af1HidugpTEZu03Resdf/a2vNmstfbjrja3a/TJlG+SyL8pumRRYPTIoYochaSJajv
        hl1QX22A==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k1OoR-0006ya-61; Fri, 31 Jul 2020 06:46:39 +0000
Date:   Fri, 31 Jul 2020 07:46:39 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Dave Chinner <david@fromorbit.com>
Cc:     Takuya Yoshikawa <takuya.yoshikawa@gmail.com>,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: ext4/xfs: about switching underlying 512B sector devices to 4K
 ones
Message-ID: <20200731064639.GB25674@infradead.org>
References: <CANR1yOpz9o9VcAiqo18aVO5ssmuSy18RxnMKR=Dz884Rj8_trg@mail.gmail.com>
 <20200729231605.GB2005@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200729231605.GB2005@dread.disaster.area>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jul 30, 2020 at 09:16:05AM +1000, Dave Chinner wrote:
> if you start with 4k devices, mkfs.xfs will detect 4k
> physical/logical devices and set it's sector size to 4k
> automatically and hence will work on those devices, but you can't
> change this retrospectively....

Alternatively you can force a larger sectors size manually at mkfs
time.

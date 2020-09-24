Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 868E527681D
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Sep 2020 07:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726788AbgIXFMh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Sep 2020 01:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgIXFMh (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Sep 2020 01:12:37 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73087C0613CE
        for <linux-ext4@vger.kernel.org>; Wed, 23 Sep 2020 22:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=FhHh+G15H3EFXAXqyT4rHyPGZXjFJazB5mfTPgGLTXg=; b=gOkyX0xVl//10MCLCUjNj9NJow
        FYlHAH2gLvbMq/HTRIqxQix7UVpfIr0h3xDky9x242ug0t9hKtxKeciWhDTAvAkyphYOPRgnC3KwZ
        +7E8sWKvsUntiEoNNkMzrQUuW0u29G0OEXkvHJKd4/NUWoYmoLqonv2v+xFy8t6uiqXxjJa07ui/v
        DAxnXtS0t5amXRgGHicMsfrmkmD5dtRTxPl+pEz+cUZsUIFkKkb4Q9iyDKTocF07T93ZiBLUlYe8r
        i7aU/s5cr1WF3SGPSYT9blXStGbITQcyO7dMpMAITBC/a0UOYOJ9MufzMQGmPR1VQPyNwJ7LxdU41
        22vzohNg==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLJYU-0004Ke-Re; Thu, 24 Sep 2020 05:12:30 +0000
Date:   Thu, 24 Sep 2020 06:12:30 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Meng Wang <meng@hcdatainc.com>, linux-ext4@vger.kernel.org,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: kernel panics when hot removing U.2 nvme disk
Message-ID: <20200924051230.GA16433@infradead.org>
References: <BYAPR10MB24561C62C45813B7092E346BCB3F0@BYAPR10MB2456.namprd10.prod.outlook.com>
 <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200919014401.GE4030837@dhcp-10-100-145-180.wdl.wdc.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Sep 18, 2020 at 06:44:01PM -0700, Keith Busch wrote:
> On Fri, Sep 18, 2020 at 11:47:27PM +0000, Meng Wang wrote:
> > Hi,
> > We found kernel panics today when doing test on hot remove U.2 nvme
> > disk. After hot remove the nvme disk (formatted as ext4), the system
> > freezes and all services stuck. Lot of kernel message flushed the
> > syslog, including the CPU soft lockup, ext4 NULL point er dereferece
> > and ib nic transmission timeout. The kernel panics and configuration
> > are shown below. The used kernel is 5.4.0-050400-generic and OS is
> > Ubuntu 16.04. Not sure whether it's a known bug or configuration
> > error. Any advise are welcome.
> 
> [cc'ing ext4 mailing list]
> 
> The NULL dereference occured before the soft lockup, so I'm guessing the
> Oops'ed process is holding the same lock the removal task wants.
> 
> Your kernel is a bit older, so it may be worth verifying if your
> observation still occurs on the current stable or current mainline, but
> the ext4 developers may have a better idea as this doesn't at least
> initially appear specific to nvme.

The problem is the crazy __invalidate_device stuff that calls into
file system eviction from all kinds of super critical block paths.
While I haven't debugged the root cause this kind of thing just causes
problems without really helping anyone.  I have a half-finished series
that kills this crap and instead allows the file system (or other
block device user) to pass shutdown and resize callbacks when the
exclusively open a block device.  That way the file system driver
can just mark the file system shutdown to prevent any further damage
without all this mess.

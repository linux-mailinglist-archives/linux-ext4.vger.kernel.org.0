Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41107502E0
	for <lists+linux-ext4@lfdr.de>; Mon, 24 Jun 2019 09:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbfFXHQP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 24 Jun 2019 03:16:15 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51740 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726472AbfFXHQP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 24 Jun 2019 03:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=j+qSh2kczzvZ1R9F9ed1//xkRvw0p8xrYDflkVqDxlo=; b=hzqqT74sdbhuMqvk57n1qxkYM
        OsxQU653r3+zMJxRJSZF5unikEM6O8DsCXUSMpuyDj/oV5VpZotJY8olqhHQm/S+KxkdmA2MDex5U
        uG2KcOJD8Huai+kgEQPE8sftGJybgJIflOPS5u7pHYj3BuRkDWsN/ES/0RkRQFQbHnU9vZLalYqUO
        Fr4HFEyWYPZ7WmH5nN+cyJXX4l6jdOTUBeBwq5AknmvHDPcgvBEQhrOeT2hz/20Gifs/zLrEJKPAC
        eiyvOuPr0d3mEAnhO8iohUuCXeasRQcIPcR/x3gQRDCSqYQsRa2nBCqkEmc0gjNNAgASAlG1Fn0N3
        ZLARmgAJA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJD0-00048i-Km; Mon, 24 Jun 2019 07:16:10 +0000
Date:   Mon, 24 Jun 2019 00:16:10 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, Eryu Guan <guaneryu@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        fstests@vger.kernel.org, linux-ext4@vger.kernel.org,
        "Lakshmipathi.G" <lakshmipathi.ganapathi@collabora.co.uk>
Subject: Re: Removing the shared class of tests
Message-ID: <20190624071610.GA10195@infradead.org>
References: <20190612184033.21845-1-krisman@collabora.com>
 <20190612184033.21845-2-krisman@collabora.com>
 <20190616144440.GD15846@desktop>
 <20190616200154.GA7251@mit.edu>
 <20190620112903.GF15846@desktop>
 <20190620162116.GA4650@mit.edu>
 <20190620175035.GA5380@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190620175035.GA5380@magnolia>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 10:50:35AM -0700, Darrick J. Wong wrote:
> > I'm not sure why shared/011 is only run on ext4 and btrfs.  Does
> > cgroup-aware writeback not work on other file systems?
> 
> IIRC it doesn't work on xfs because the author never quite answered
> Dave's question about whether or not it would cause ... io priority
> inversions or something?  There was some unanswered question (iirc) so
> nobody RVB'd the patch and it never went upstream.

I've got a new and tested patch to support cgroup writeback on xfs that
I'll send out today.  But even with that lots of file systems don't
support cgroup writeback and there is no easy way to autodetect the
support.  As far as I an tell ext2 and f2fs also support cgroup
writeback, so they should be added a well.


As for the higher level question?  The shared tests always confused the
heck out of me.  generic with the right feature checks seem like a much
better idea.

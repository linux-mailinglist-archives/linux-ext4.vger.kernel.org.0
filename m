Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87D13B218
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 19:27:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727331AbgANS1i (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 13:27:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:55110 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgANS1i (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 13:27:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=zmkp7vQ9ClPuKwJmCDKaq1sP9qHx2/tUi7SX3AWcZnE=; b=Fiy1HBwLAhrH+05FpSFeaX9ZE
        N3kcGRj7mJezus/R4YiigXeuVlplr5RroPsScmnaJY7TtfmCZtUrJzOh7YrL7MKU2tuhEVW9QeuDG
        9ntIUhq/MaOa9yiiV5CegCm4TcqQATJ3LGqDydDWA8K4mmOTEpKbntC+jwj6hjlThcCu9QtoXAbSj
        4uPIfi4YcMkenkdNRpMBit6HhdY8NljeyhqQ0ygwep6Bp9nYQTLNYSCMjnYRb2OWttNybbjFVdSQ0
        YcTiKybPR/fybeIDx0YSEACpg4fcEiX3OcrCZsN1GRp0orG92b+lAj1kCcMG53yI7H8Arr51yT/O7
        TNEkSdpAA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irQue-0007rk-N3; Tue, 14 Jan 2020 18:27:36 +0000
Date:   Tue, 14 Jan 2020 10:27:36 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114182736.GA27370@infradead.org>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
 <20200114163702.GA7127@infradead.org>
 <20200114171934.GB22081@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114171934.GB22081@quack2.suse.cz>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Jan 14, 2020 at 06:19:34PM +0100, Jan Kara wrote:
> We want to detect in the writeback path whether there's direct IO (read)
> currently running for the inode. Not for the writeback issued from
> iomap_dio_rw() but for any arbitrary writeback that iomap_dio_rw() can be
> racing with - so struct writeback_control won't help. Now if you want to
> see the ugly details why this hack is needed, see my other email to Ritesh
> in this thread with details of the race.

How do we get other writeback after iomap_dio_rw wrote everything out?
Either way I'm trying to kill i_dio_count as it has all kinds of
problems, see the patch sent out earlier today.

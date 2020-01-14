Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE84013AF8C
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 17:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbgANQhD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 11:37:03 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:56522 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgANQhC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 11:37:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=bJVaCxrwr35SB36/aaUlnDWktHBHuj0zzwzpoSHUEtA=; b=tnFM93Uqm/bykCKgamD0hnO71
        XP1CdKWoB/HK8TuWpqMrQ0x7QXiwnq7GRhtz7bqqa8ph2tOVP64c/qJ6FV+NNEhibNfzlJ33o0my8
        VFd/lvz/GQXoMFth57L1AqL+pZVlnWS8Z3Ozg/aeGbg+dfe+s77cZ1CBC5BisFCpAWWkF/XtHTzFy
        ouDrykJY4LPC1t5d0q3LfuY3KYUom7mhZThvlRNIq1BNCTSiGZNca3erHg1roAp0Td5NKBAa8KXlG
        uXMpsG4rgoHZHlve0dkxHtZFQnYtt/4gOPp3SVqzW+WCR5IUkPImENsEHHkHssABcRNYUE1g/Dc/j
        XX3jgrXHQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irPBe-00037l-Hn; Tue, 14 Jan 2020 16:37:02 +0000
Date:   Tue, 14 Jan 2020 08:37:02 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 1/2] iomap: direct-io: Move inode_dio_begin before
 filemap_write_and_wait_range
Message-ID: <20200114163702.GA7127@infradead.org>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
 <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27607a16327fe9664f32d09abe565af0d1ae56c9.1578907891.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Please add at very least the fsdevel and xfs lists to iomap patches.

Using i_dio_count for any kind of detection is bogus.  If you want to
pass flags to the writeback code please do so explicitly through
struct writeback_control.

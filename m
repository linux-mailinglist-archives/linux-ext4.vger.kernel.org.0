Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E215913AF95
	for <lists+linux-ext4@lfdr.de>; Tue, 14 Jan 2020 17:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728739AbgANQjq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Jan 2020 11:39:46 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:57986 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgANQjq (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Jan 2020 11:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MWUG6OEk5N6aLbF2egdX4Llo3zdvVJbkHOI4p8bRXFU=; b=Zv57H1W5kZlvr+3Ryh6cBdijk
        pNqCUJbuPyx2K9VKtFcphnQ3lEmYEVHTxFmJHSmDGFHkLkFwka/HaDhnDkqQNRUeZRCS38XPutnUl
        AqMFKjrexKhXy2uBf3XNWUZhT7IjzHsvCv0GHoHWISBruByOsZ5019OAQWEHF9lP7mg7XKMsLO85G
        owH8mHPiZ98fu2GAttRzj5XMP1DKAmqkxZEZnVAVbepoKccZ32UKs0rE9ClGb6sdRt3arSNUr4k5o
        0vpEIfvUMHMbrQF4+RkPP57Wxn43vxDvxJYcUSIOwQhte3HqRXDsCAfA9CtBFCGVW+Yi7O430JRnu
        FwdhFppWA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1irPEH-0003Y5-PF; Tue, 14 Jan 2020 16:39:45 +0000
Date:   Tue, 14 Jan 2020 08:39:45 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, jack@suse.cz
Subject: Re: [RFC 0/2] ext4: Fix stale data read exposure problem with DIO
 read/page_mkwrite
Message-ID: <20200114163945.GC7127@infradead.org>
References: <cover.1578907890.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1578907890.git.riteshh@linux.ibm.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> Currently there is a small race window as pointed out by Jan [2] where, when
> ext4 tries to allocate a written block for mapped files and if DIO read is in
> progress, then this may result into stale data read exposure problem.

Do we have a test case for the problem?

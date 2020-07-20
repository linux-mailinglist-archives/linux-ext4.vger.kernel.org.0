Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF2BF2271E6
	for <lists+linux-ext4@lfdr.de>; Mon, 20 Jul 2020 23:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgGTVvb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 20 Jul 2020 17:51:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:49732 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgGTVvb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 20 Jul 2020 17:51:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C8900ABF4;
        Mon, 20 Jul 2020 21:51:35 +0000 (UTC)
Date:   Mon, 20 Jul 2020 16:51:25 -0500
From:   Goldwyn Rodrigues <rgoldwyn@suse.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Dave Chinner <david@fromorbit.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        cluster-devel@redhat.com, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: RFC: iomap write invalidation
Message-ID: <20200720215125.bfz7geaftocy4r5l@fiona>
References: <20200713074633.875946-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713074633.875946-1-hch@lst.de>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Christoph,

On  9:46 13/07, Christoph Hellwig wrote:
> Hi all,
> 
> this series has two parts:  the first one picks up Dave's patch to avoid
> invalidation entierly for reads, picked up deep down from the btrfs iomap
> thread.  The second one falls back to buffered writes if invalidation fails
> instead of leaving a stale cache around.  Let me know what you think about
> this approch.

Which kernel version are these changes expected?
btrfs dio switch to iomap depends on this.

-- 
Goldwyn

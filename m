Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55E9849EE1F
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jan 2022 23:33:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiA0WdD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Jan 2022 17:33:03 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59514 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239018AbiA0WdC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Jan 2022 17:33:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 58858B801BC;
        Thu, 27 Jan 2022 22:33:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F867C340E4;
        Thu, 27 Jan 2022 22:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1643322780;
        bh=KyW09W85IPjR9zNAkKrCh5PNjr0Umrx44954UKFP4jQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fP5wmZtdgiZu/FrP7PhOokkdSv2iz/JRlELCy8KE3PxjZuPikwpGG5u5M86BQ8QMB
         YREDewXYuQr0LO2GLNCUrm5xL3I2VEh6uMOCa4PMzmbgQscCQY6FGwQC1Pb/zu6qoU
         n+kfJ6iphf95sdN39zm7Uy1KfETp70xNuWJ1zn54=
Date:   Thu, 27 Jan 2022 14:32:58 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     <Felix.Kuehling@amd.com>, <linux-mm@kvack.org>,
        <rcampbell@nvidia.com>, <linux-ext4@vger.kernel.org>,
        <linux-xfs@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <hch@lst.de>, <jgg@nvidia.com>,
        <jglisse@redhat.com>, <apopple@nvidia.com>, <willy@infradead.org>
Subject: Re: [PATCH v4 00/10] Add MEMORY_DEVICE_COHERENT for coherent device
 memory mapping
Message-Id: <20220127143258.8da663659948ad1e6f0c0ea8@linux-foundation.org>
In-Reply-To: <20220127030949.19396-1-alex.sierra@amd.com>
References: <20220127030949.19396-1-alex.sierra@amd.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 26 Jan 2022 21:09:39 -0600 Alex Sierra <alex.sierra@amd.com> wrote:

> This patch series introduces MEMORY_DEVICE_COHERENT, a type of memory
> owned by a device that can be mapped into CPU page tables like
> MEMORY_DEVICE_GENERIC and can also be migrated like
> MEMORY_DEVICE_PRIVATE.

Some more reviewer input appears to be desirable here.

I was going to tentatively add it to -mm and -next, but problems. 
5.17-rc1's mm/migrate.c:migrate_vma_check_page() is rather different
from the tree you patched.  Please redo, refresh and resend?


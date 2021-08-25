Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7366A3F70A9
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238841AbhHYHsN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 03:48:13 -0400
Received: from verein.lst.de ([213.95.11.211]:55163 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238809AbhHYHsM (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 25 Aug 2021 03:48:12 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0963B67357; Wed, 25 Aug 2021 09:47:26 +0200 (CEST)
Date:   Wed, 25 Aug 2021 09:47:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 08/14] mm: add public type support to migrate_vma
 helpers
Message-ID: <20210825074725.GC29620@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-9-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210825034828.12927-9-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This should probably be folded into patch 4.

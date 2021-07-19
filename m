Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA3053CD071
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Jul 2021 11:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbhGSIhB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 19 Jul 2021 04:37:01 -0400
Received: from verein.lst.de ([213.95.11.211]:48645 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235031AbhGSIhB (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 19 Jul 2021 04:37:01 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 330C468B05; Mon, 19 Jul 2021 11:17:39 +0200 (CEST)
Date:   Mon, 19 Jul 2021 11:17:38 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Alex Sierra <alex.sierra@amd.com>
Cc:     akpm@linux-foundation.org, Felix.Kuehling@amd.com,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v4 05/13] drm/amdkfd: generic type as sys mem on
 migration to ram
Message-ID: <20210719091738.GB30855@lst.de>
References: <20210717192135.9030-1-alex.sierra@amd.com> <20210717192135.9030-6-alex.sierra@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210717192135.9030-6-alex.sierra@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jul 17, 2021 at 02:21:27PM -0500, Alex Sierra wrote:
> +	migrate.flags = adev->gmc.xgmi.connected_to_cpu ?
> +			MIGRATE_VMA_SELECT_SYSTEM : MIGRATE_VMA_SELECT_DEVICE_PRIVATE;

Please just use a good old if/else to keep the code readable.

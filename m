Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19E7B3FB277
	for <lists+linux-ext4@lfdr.de>; Mon, 30 Aug 2021 10:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234532AbhH3I25 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 30 Aug 2021 04:28:57 -0400
Received: from verein.lst.de ([213.95.11.211]:39672 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233318AbhH3I25 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 30 Aug 2021 04:28:57 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1655A68AFE; Mon, 30 Aug 2021 10:28:00 +0200 (CEST)
Date:   Mon, 30 Aug 2021 10:28:00 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Felix Kuehling <felix.kuehling@amd.com>
Cc:     "Sierra Guiza, Alejandro (Alex)" <alex.sierra@amd.com>,
        Christoph Hellwig <hch@lst.de>, akpm@linux-foundation.org,
        linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        jgg@nvidia.com, jglisse@redhat.com
Subject: Re: [PATCH v1 03/14] mm: add iomem vma selection for memory
 migration
Message-ID: <20210830082800.GA6836@lst.de>
References: <20210825034828.12927-1-alex.sierra@amd.com> <20210825034828.12927-4-alex.sierra@amd.com> <20210825074602.GA29620@lst.de> <c4241eb3-07d2-c85b-0f48-cce4b8369381@amd.com> <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a9eb2c4a-d8cc-9553-57b7-fd1622679aaa@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Aug 26, 2021 at 06:27:31PM -0400, Felix Kuehling wrote:
> I think we're missing something here. As far as I can tell, all the work
> we did first with DEVICE_GENERIC and now DEVICE_PUBLIC always used
> normal pages. Are we missing something in our driver code that would
> make these PTEs special? I don't understand how that can be, because
> driver code is not really involved in updating the CPU mappings. Maybe
> it's something we need to do in the migration helpers.

It looks like I'm totally misunderstanding what you are adding here
then.  Why do we need any special treatment at all for memory that
has normal struct pages and is part of the direct kernel map?

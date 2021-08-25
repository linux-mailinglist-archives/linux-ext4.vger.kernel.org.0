Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E263F742E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Aug 2021 13:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240310AbhHYLQK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Aug 2021 07:16:10 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:35616 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240087AbhHYLQJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Aug 2021 07:16:09 -0400
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 362FD200F2;
        Wed, 25 Aug 2021 11:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629890121; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsTZ/9+VRszmlL6hS/sFGVn+Amn3Nh4I4j0bZJL/75s=;
        b=I7Yi38O5i1rcyp1b3zu0aSxtw2cF3Go7OkwlsISIti7iULIxygNwNF0BH36F2+avkbLNcW
        06YUDL+y1Hbvft7P8mvdvOug3JHSgTatWoeMMjAU6Kx57OmI+805Z/qH6eqDuglFihBtQJ
        CNQ9ji0e3uopyLcJZU5kVtj7OSQqX1U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629890121;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsTZ/9+VRszmlL6hS/sFGVn+Amn3Nh4I4j0bZJL/75s=;
        b=A3w6EnRWXBALysZo9aIw4XjrVtAuedgCl1SGMlGblXmqQ2/TW5TK15Z3OuRoWQj96Fsrp8
        vyntj+rs4FdH9vBQ==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id F408413732;
        Wed, 25 Aug 2021 11:15:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap1.suse-dmz.suse.de with ESMTPSA
        id JNBiOkgmJmH7GwAAGKfGzw
        (envelope-from <vbabka@suse.cz>); Wed, 25 Aug 2021 11:15:20 +0000
Message-ID: <dbd0f54a-ad6c-97a2-17d7-826247424c97@suse.cz>
Date:   Wed, 25 Aug 2021 13:15:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.1
Subject: Re: [PATCH v1 02/14] mm: remove extra ZONE_DEVICE struct page
 refcount
Content-Language: en-US
To:     Alex Sierra <alex.sierra@amd.com>, akpm@linux-foundation.org,
        Felix.Kuehling@amd.com, linux-mm@kvack.org, rcampbell@nvidia.com,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        hch@lst.de, jgg@nvidia.com, jglisse@redhat.com
References: <20210825034828.12927-1-alex.sierra@amd.com>
 <20210825034828.12927-3-alex.sierra@amd.com>
From:   Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <20210825034828.12927-3-alex.sierra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 8/25/21 05:48, Alex Sierra wrote:
> From: Ralph Campbell <rcampbell@nvidia.com>
> 
> ZONE_DEVICE struct pages have an extra reference count that complicates the
> code for put_page() and several places in the kernel that need to check the
> reference count to see that a page is not being used (gup, compaction,
> migration, etc.). Clean up the code so the reference count doesn't need to
> be treated specially for ZONE_DEVICE.

That's certainly welcome. I just wonder what was the reason to use 1 in the
first place and why it's no longer necessary?

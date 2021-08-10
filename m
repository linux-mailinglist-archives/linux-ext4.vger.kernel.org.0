Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 591993E7B95
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Aug 2021 17:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242012AbhHJPB6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Aug 2021 11:01:58 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240809AbhHJPB4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Aug 2021 11:01:56 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17AF1UAK016806
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 10 Aug 2021 11:01:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 72B3A15C3DD0; Tue, 10 Aug 2021 11:01:30 -0400 (EDT)
Date:   Tue, 10 Aug 2021 11:01:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH 3/7] e2fsprogs: fix unexpected NULL variable
Message-ID: <YRKUyu4F2f2rQTXc@mit.edu>
References: <20210806095820.83731-1-lczerner@redhat.com>
 <20210806095820.83731-3-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210806095820.83731-3-lczerner@redhat.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Aug 06, 2021 at 11:58:16AM +0200, Lukas Czerner wrote:
> The ext2fs_check_mount_point() function can be called with mtpt being
> NULL as for example from ext2fs_check_if_mounted(). However in the
> is_swap_device condition we use the mtpt in strncpy without checking
> whether it is non-null first.
> 
> This should not be a problem on linux since the previous attempt to open
> the device exclusively would have prevented us from ever reaching the
> problematic strncpy. However it's still a bug and can cause problems on
> other systems, fix it by conditioning strncpy on mtpt not being null.
> 
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>

Applied, thanks.

					- Ted

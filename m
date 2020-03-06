Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5F3A17B39C
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Mar 2020 02:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCFBPD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Mar 2020 20:15:03 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36288 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726173AbgCFBPD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Mar 2020 20:15:03 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-105.corp.google.com [104.133.0.105] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0261EgCi000943
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 5 Mar 2020 20:14:43 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id D7BEF42045B; Thu,  5 Mar 2020 20:14:41 -0500 (EST)
Date:   Thu, 5 Mar 2020 20:14:41 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "zhangyi (F)" <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH] jbd2: improve comments about freeing data buffers whose
 page mapping is NULL
Message-ID: <20200306011441.GJ20967@mit.edu>
References: <20200217112706.20085-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200217112706.20085-1-yi.zhang@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Feb 17, 2020 at 07:27:06PM +0800, zhangyi (F) wrote:
> Improve comments in jbd2_journal_commit_transaction() to describe why
> we don't need to clear the buffer_mapped bit for freeing file mapping
> buffers whose page mapping is NULL.
> 
> Fixes: c96dceeabf76 ("jbd2: do not clear the BH_Mapped flag when forgetting a metadata buffer")
> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> Suggested-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted

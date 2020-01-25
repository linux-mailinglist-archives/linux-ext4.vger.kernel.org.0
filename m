Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 490661493E6
	for <lists+linux-ext4@lfdr.de>; Sat, 25 Jan 2020 08:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgAYH02 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 25 Jan 2020 02:26:28 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52179 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726293AbgAYH02 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 25 Jan 2020 02:26:28 -0500
Received: from callcc.thunk.org (rrcs-67-53-201-206.west.biz.rr.com [67.53.201.206])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00P7QDFv025688
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 25 Jan 2020 02:26:18 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7E25742014A; Sat, 25 Jan 2020 02:26:12 -0500 (EST)
Date:   Sat, 25 Jan 2020 02:26:12 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Shijie Luo <luoshijie1@huawei.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz
Subject: Re: [PATCH v2] jbd2: remove pointless assertion in
 __journal_remove_journal_head
Message-ID: <20200125072612.GG1108497@mit.edu>
References: <20200123070054.50585-1-luoshijie1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200123070054.50585-1-luoshijie1@huawei.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 23, 2020 at 02:00:54AM -0500, Shijie Luo wrote:
> Only when jh->b_jcount = 0 in jbd2_journal_put_journal_head, we are allowed
> to call __journal_remove_journal_head. This assertion is meaningless,
> just remove it.
> 
> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

					- Ted

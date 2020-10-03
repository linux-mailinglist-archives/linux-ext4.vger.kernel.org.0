Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24A4E282113
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 06:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725681AbgJCEPm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 00:15:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42004 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCEPm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 00:15:42 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0934FYYo020226
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 00:15:35 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7E59942003C; Sat,  3 Oct 2020 00:15:34 -0400 (EDT)
Date:   Sat, 3 Oct 2020 00:15:34 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Dinghao Liu <dinghao.liu@zju.edu.cn>
Cc:     kjlu@umn.edu, Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] ext4: Fix error handling code in add_new_gdb
Message-ID: <20201003041534.GC23474@mit.edu>
References: <20200829025403.3139-1-dinghao.liu@zju.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200829025403.3139-1-dinghao.liu@zju.edu.cn>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Aug 29, 2020 at 10:54:02AM +0800, Dinghao Liu wrote:
> When ext4_journal_get_write_access() fails, we should
> terminate the execution flow and release n_group_desc,
> iloc.bh, dind and gdb_bh.
> 
> Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>

Thanks, applied.

				- Ted

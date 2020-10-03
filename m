Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5112A28217F
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Oct 2020 07:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725648AbgJCFGp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 3 Oct 2020 01:06:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55436 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725446AbgJCFGp (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 3 Oct 2020 01:06:45 -0400
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 09356eg7022775
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 3 Oct 2020 01:06:41 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 7D38E42003C; Sat,  3 Oct 2020 01:06:40 -0400 (EDT)
Date:   Sat, 3 Oct 2020 01:06:40 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Chunguang Xu <brookxu.cn@gmail.com>
Cc:     adilger.kernel@dilger.ca, adilger@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2 RESEND 1/2] ext4: rename journal_dev to s_journal_dev
 inside ext4_sb_info
Message-ID: <20201003050640.GJ23474@mit.edu>
References: <1600916623-544-1-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1600916623-544-1-git-send-email-brookxu@tencent.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 11:03:42AM +0800, Chunguang Xu wrote:
> From: Chunguang Xu <brookxu@tencent.com>
> 
> Rename journal_dev to s_journal_dev inside ext4_sb_info, keep
> the naming rules consistent with other variables, which is
> convenient for code reading and writing.
> 
> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> Reviewed-by: Andreas Dilger <adilger@dilger.ca>
> Reviewed-by: Ritesh Harjani <riteshh@linux.ibm.com>

Applied, thanks.

					- Ted

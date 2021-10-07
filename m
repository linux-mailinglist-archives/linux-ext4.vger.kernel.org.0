Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DE342570A
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 17:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbhJGPvy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 11:51:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54297 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241686AbhJGPvx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 11:51:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197Fnh66000312
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 11:49:44 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C03EB15C3E70; Thu,  7 Oct 2021 11:49:43 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yangerkun <yangerkun@huawei.com>, jack@suse.cz
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH 0/3] bugfix for insert/collapse fallocate
Date:   Thu,  7 Oct 2021 11:49:42 -0400
Message-Id: <163362175420.615223.2395593389813136493.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210903062748.4118886-1-yangerkun@huawei.com>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 3 Sep 2021 14:27:45 +0800, yangerkun wrote:
> yangerkun (3):
>   ext4: correct the left/middle/right debug message for binsearch
>   ext4: ensure enough credits in ext4_ext_shift_path_extents
>   ext4: stop use path once restart journal in
>     ext4_ext_shift_path_extents
> 
> fs/ext4/extents.c | 77 ++++++++++++++++++++++-------------------------
>  1 file changed, 36 insertions(+), 41 deletions(-)
> 
> [...]

Applied, thanks!

[1/3] ext4: correct the left/middle/right debug message for binsearch
      commit: 189487c02b3865c35be3ced27ebc33f7bfe86220
[2/3] ext4: ensure enough credits in ext4_ext_shift_path_extents
      commit: 42c018ecf2bcf37c21476942bb96662fad7133c0
[3/3] ext4: stop use path once restart journal in ext4_ext_shift_path_extents
      commit: d56aaa1fa17ff4b45383c8beb36bb6a1cf835e22

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

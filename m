Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB5FE4059C6
	for <lists+linux-ext4@lfdr.de>; Thu,  9 Sep 2021 16:55:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232359AbhIIO4y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 9 Sep 2021 10:56:54 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:60947 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S234825AbhIIO4x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 9 Sep 2021 10:56:53 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 189EtU5s030545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 9 Sep 2021 10:55:31 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CCEB515C33EC; Thu,  9 Sep 2021 10:55:30 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        adilger.kernel@dilger.ca, yukuai3@huawei.com
Subject: Re: [PATCH v3 0/4] ext4: improve delalloc buffer write performance
Date:   Thu,  9 Sep 2021 10:55:22 -0400
Message-Id: <163119924594.1572869.9093216296626510411.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210716122024.1105856-1-yi.zhang@huawei.com>
References: <20210716122024.1105856-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 16 Jul 2021 20:20:20 +0800, Zhang Yi wrote:
> Changes since v2:
>  - Patch 3: fix misleading comment about data truncate in the error path
>             of ext4_write_inline_data_end().
> 
> Thanks,
> Yi.
> 
> [...]

Applied, thanks!

[1/4] ext4: check and update i_disksize properly
      commit: 4df031ff5876d94b48dd9ee486ba5522382a06b2
[2/4] ext4: correct the error path of ext4_write_inline_data_end()
      commit: 55ce2f649b9e88111270333a8127e23f4f8f42d7
[3/4] ext4: factor out write end code of inline file
      commit: 6984aef59814fb5c47b0e30c56e101186b5ebf8c
[4/4] ext4: drop unnecessary journal handle in delalloc write
      commit: cc883236b79297f6266ca6f4e7f24f3fd3c736c1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

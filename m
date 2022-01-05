Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1BD485C53
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 00:39:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiAEXjx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 18:39:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33802 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245445AbiAEXjv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 18:39:51 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 205Ndl71017585
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 18:39:47 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id F23F215C339C; Wed,  5 Jan 2022 18:39:46 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Nghia Le <nghialm78@gmail.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, lukas.bulwahn@gmail.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] ext4: remove useless resetting io_end_size in mpage_process_page()
Date:   Wed,  5 Jan 2022 18:39:45 -0500
Message-Id: <164142575579.441490.5053656243661327373.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211025221803.3326-1-nghialm78@gmail.com>
References: <20211025221803.3326-1-nghialm78@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 26 Oct 2021 05:18:03 +0700, Nghia Le wrote:
> The command "make clang-analyzer" detects dead stores in
> mpage_process_page() function.
> 
> Do not reset io_end_size to 0 in the current paths, as the function
> exits on those paths without further using io_end_size.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: remove useless resetting io_end_size in mpage_process_page()
      commit: 2e1a1101de1e37c80c750c2657cc35d7f560756c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

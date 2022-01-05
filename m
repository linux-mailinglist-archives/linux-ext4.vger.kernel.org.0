Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E247485C51
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 00:39:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245447AbiAEXjx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 18:39:53 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33801 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S245409AbiAEXjv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 18:39:51 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 205Ndlnc017583
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 18:39:47 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id ED5BD15C00E3; Wed,  5 Jan 2022 18:39:46 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Zeal Robot <zealci@zte.com.cn>,
        luo penghao <luo.penghao@zte.com.cn>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>
Subject: Re: [PATCH v2] ext4: Remove unused assignments
Date:   Wed,  5 Jan 2022 18:39:44 -0500
Message-Id: <164142575580.441490.12156844254814262007.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211104064007.2919-1-luo.penghao@zte.com>
References: <20211104064007.2919-1-luo.penghao@zte.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 4 Nov 2021 06:40:07 +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The eh assignment in these two places is meaningless, because the
> function will goto to merge, which will not use eh.
> 
> The clang_analyzer complains as follows:
> 
> [...]

Applied, thanks!

[1/1] ext4: remove unused assignments
      commit: 4bf7773e5a636b80de2b9025a7e107b38fe189b9

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CEF485FF1
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jan 2022 05:42:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbiAFEmA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Jan 2022 23:42:00 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39509 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229729AbiAFEl7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Jan 2022 23:41:59 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2064ftFE003548
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Jan 2022 23:41:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0A6A415C00E3; Wed,  5 Jan 2022 23:41:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     cgel.zte@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org,
        luo penghao <luo.penghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] ext4: Remove redundant o_start statements
Date:   Wed,  5 Jan 2022 23:41:50 -0500
Message-Id: <164144408579.468293.9021095894366334797.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211208075157.404535-1-luo.penghao@zte.com.cn>
References: <20211208075157.404535-1-luo.penghao@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 8 Dec 2021 07:51:57 +0000, cgel.zte@gmail.com wrote:
> From: luo penghao <luo.penghao@zte.com.cn>
> 
> The if will goto out of the loop, and until the end of the
> function execution, o_start will not be used again.
> 
> The clang_analyzer complains as follows:
> 
> [...]

Applied, thanks!

[1/1] ext4: Remove redundant o_start statements
      commit: b687e7ba0849122bf862639b98256a0b984a940a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

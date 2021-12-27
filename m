Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F199947FA58
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 06:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhL0Few (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 00:34:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35662 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232405AbhL0Fev (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 00:34:51 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR5YjmZ027873
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 00:34:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 767E715C343F; Mon, 27 Dec 2021 00:34:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH] ext4: initialize err_blk before calling __ext4_get_inode_loc
Date:   Mon, 27 Dec 2021 00:34:40 -0500
Message-Id: <164058326343.3172825.15437605402613198910.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211201163421.2631661-1-harshads@google.com>
References: <20211201163421.2631661-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 1 Dec 2021 08:34:21 -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> It is not guaranteed that __ext4_get_inode_loc will definitely set
> err_blk pointer when it returns EIO. To avoid using uninitialized
> variables, let's first set err_blk to 0.
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: initialize err_blk before calling __ext4_get_inode_loc
      commit: 613da7163720054004f596e5f5230753b50a7f45

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

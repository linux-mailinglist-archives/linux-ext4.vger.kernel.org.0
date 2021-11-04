Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F86544558F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Nov 2021 15:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229577AbhKDOrB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 4 Nov 2021 10:47:01 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:32919 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229505AbhKDOq7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 4 Nov 2021 10:46:59 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A4EiIt4016587
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 4 Nov 2021 10:44:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 6AB8E15C00B9; Thu,  4 Nov 2021 10:44:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 1/2] ext4: commit inline data during fast commit
Date:   Thu,  4 Nov 2021 10:44:16 -0400
Message-Id: <163603704482.2752249.11675165495055132631.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211015182513.395917-1-harshads@google.com>
References: <20211015182513.395917-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 15 Oct 2021 11:25:12 -0700, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> During the commit phase in fast commits if an inode with inline data
> is being committed, also commit the inline data along with
> inode. Since recovery code just blindly copies entire content found in
> inode TLV, there is no change needed on the recovery path. Thus, this
> change is backward compatiable.
> 
> [...]

Applied, thanks!

[1/2] ext4: commit inline data during fast commit
      commit: 6c31a689b2e9e1dee5cbe16b773648a2d84dfb02
[2/2] ext4: inline data inode fast commit replay fixes
      commit: 1ebf21784b19d5bc269f39a5d1eedb7f29a7d152

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

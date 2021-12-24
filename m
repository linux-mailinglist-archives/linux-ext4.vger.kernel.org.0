Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B421147E9DC
	for <lists+linux-ext4@lfdr.de>; Fri, 24 Dec 2021 01:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350434AbhLXA2C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Dec 2021 19:28:02 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:41337 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1350410AbhLXA2B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Dec 2021 19:28:01 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BO0RqLa003095
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 23 Dec 2021 19:27:53 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 80EE315C339D; Thu, 23 Dec 2021 19:27:52 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshadshirwadkar@gmail.com, adilger.kernel@dilger.ca,
        Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
Date:   Thu, 23 Dec 2021 19:27:51 -0500
Message-Id: <164030564165.2940033.13491679644853079214.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211221022839.374606-1-yinxin.x@bytedance.com>
References: <20211221022839.374606-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 21 Dec 2021 10:28:39 +0800, Xin Yin wrote:
> when call falloc with FALLOC_FL_ZERO_RANGE, to set an range to unwritten,
> which has been already initialized. If the range is align to blocksize,
> fast commit will not track range for this change.
> 
> Also track range for unwritten range in ext4_map_blocks().
> 
> 
> [...]

Applied, thanks!

[1/1] ext4: fix fast commit may miss tracking range for FALLOC_FL_ZERO_RANGE
      commit: f6c90a2bcabcfc56d91aa5091b76ce8082de7d68

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

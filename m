Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECFB4A2BA7
	for <lists+linux-ext4@lfdr.de>; Sat, 29 Jan 2022 05:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352382AbiA2En7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Jan 2022 23:43:59 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35050 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230099AbiA2En7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Jan 2022 23:43:59 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 20T4hmuB000785
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 28 Jan 2022 23:43:49 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BEC0415C0040; Fri, 28 Jan 2022 23:43:48 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, harshadshirwadkar@gmail.com,
        Xin Yin <yinxin.x@bytedance.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] ext4: fix incorrect type issue during replay_del_range
Date:   Fri, 28 Jan 2022 23:43:46 -0500
Message-Id: <164343140048.816481.16849444907208284442.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220126063146.2302-1-yinxin.x@bytedance.com>
References: <20220126063146.2302-1-yinxin.x@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 26 Jan 2022 14:31:46 +0800, Xin Yin wrote:
> should not use fast commit log data directly, add le32_to_cpu().
> 
> 

Applied, thanks!

[1/1] ext4: fix incorrect type issue during replay_del_range
      commit: 3f6a7abe77c1cbe125e2f743568c810470d66e7d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB66542553F
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Oct 2021 16:21:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242013AbhJGOXk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 10:23:40 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:37124 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S241042AbhJGOXk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 10:23:40 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 197ELfBE021443
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Oct 2021 10:21:41 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1635015C34DF; Thu,  7 Oct 2021 10:21:41 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Shaoying Xu <shaoyi@amazon.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, benh@amazon.com
Subject: Re: [PATCH 0/1] [RESEND] ext4: fix lazy initialization next schedule time computation in more granular unit
Date:   Thu,  7 Oct 2021 10:21:34 -0400
Message-Id: <163361646350.569327.18128912303237466845.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210902164412.9994-1-shaoyi@amazon.com>
References: <20210902164412.9994-1-shaoyi@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 2 Sep 2021 16:44:11 +0000, Shaoying Xu wrote:
> Description
> ===========
> Ext4 FS has inappropriate implementations on the next schedule time calculation
> that use jiffies to measure the time for one request to zero out inode table. This
> actually makes the wait time effectively dependent on CONFIG_HZ, which is
> undesirable. We have observed on server systems with 100HZ some fairly long delays
> in initialization as a result. Therefore, we propose to use more granular unit to
> calculate the next schedule time.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix lazy initialization next schedule time computation in more granular unit
      commit: 3782027982881d2c1105ffe058aecb69cc780dfa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

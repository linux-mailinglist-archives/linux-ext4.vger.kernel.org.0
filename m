Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3042CB4F
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Oct 2021 22:46:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhJMUsg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 13 Oct 2021 16:48:36 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59876 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229496AbhJMUsf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 13 Oct 2021 16:48:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19DKkM9b003484
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Oct 2021 16:46:22 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 230C115C00CA; Wed, 13 Oct 2021 16:46:22 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Xiyu Yang <xiyuyang19@fudan.edu.cn>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, Xin Tan <tanxin.ctf@gmail.com>,
        yuanxzhang@fudan.edu.cn
Subject: Re: [PATCH] ext4: Convert from atomic_t to refcount_t on ext4_io_end->count
Date:   Wed, 13 Oct 2021 16:46:15 -0400
Message-Id: <163415796177.214938.11748904502433521688.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1626674355-55795-1-git-send-email-xiyuyang19@fudan.edu.cn>
References: <1626674355-55795-1-git-send-email-xiyuyang19@fudan.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, 19 Jul 2021 13:59:14 +0800, Xiyu Yang wrote:
> refcount_t type and corresponding API can protect refcounters from
> accidental underflow and overflow and further use-after-free situations.
> 
> 

Applied, thanks!

[1/1] ext4: Convert from atomic_t to refcount_t on ext4_io_end->count
      commit: 6333c4e6167b01a27a6d13bd7bbeb9451d4067c1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28353EB726
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 16:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240915AbhHMO5m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 10:57:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53850 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S240198AbhHMO5m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 10:57:42 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DEv8U5015483
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 10:57:09 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C27A715C37C1; Fri, 13 Aug 2021 10:57:08 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, Guoqing Jiang <guoqing.jiang@linux.dev>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: reduce arguments of ext4_fc_add_dentry_tlv
Date:   Fri, 13 Aug 2021 10:56:58 -0400
Message-Id: <162886656352.302310.4277022620131623319.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
References: <20210727080708.3708814-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 27 Jul 2021 16:07:08 +0800, Guoqing Jiang wrote:
> Let's pass fc_dentry directly since those arguments (tag, parent_ino and
> ino etc) can be deferenced from it.

Applied, thanks!

[1/1] ext4: reduce arguments of ext4_fc_add_dentry_tlv
      commit: 78e89124cc42a0cbaf214ecd5021ee19ca4f9294

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

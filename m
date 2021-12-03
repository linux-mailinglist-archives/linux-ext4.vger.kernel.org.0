Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F904467E94
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Dec 2021 21:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382973AbhLCUGM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Dec 2021 15:06:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58577 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353557AbhLCUGM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Dec 2021 15:06:12 -0500
Received: from callcc.thunk.org (96-65-121-81-static.hfc.comcastbusiness.net [96.65.121.81])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B3K2h7I000704
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 3 Dec 2021 15:02:44 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 6F2484205DB; Fri,  3 Dec 2021 15:02:43 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] e2fsck: skip sorting extents if there are no valid extents
Date:   Fri,  3 Dec 2021 15:02:41 -0500
Message-Id: <163856175231.718374.10891843048915003777.b4-ty@mit.edu>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20211117165015.1637593-1-harshads@google.com>
References: <20211117165015.1637593-1-harshads@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 17 Nov 2021 08:50:15 -0800, Harshad Shirwadkar wrote:
> From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> 
> At the end of a fast commit replay, e2fsck tries merging extents in a
> inode. This patch fixes a bug in this logic where we were continuing
> this action even if there were no extents to merge resulting in
> accessing illegal memory.
> 
> [...]

Applied, thanks!

[1/1] e2fsck: skip sorting extents if there are no valid extents
      commit: 54183fea07676d185b2c169c45a7c1adc7e3e26e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

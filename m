Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BD0347FA55
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 06:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230342AbhL0Feu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 00:34:50 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35647 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229486AbhL0Fet (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 00:34:49 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR5Yj66027874
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 00:34:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7FC6715C3443; Mon, 27 Dec 2021 00:34:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Qing Wang <wangqing@vivo.com>, linux-kernel@vger.kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH] ext4: replace snprintf in show functions with sysfs_emit
Date:   Mon, 27 Dec 2021 00:34:42 -0500
Message-Id: <164058326343.3172825.14608730688555877995.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <1634095731-4528-1-git-send-email-wangqing@vivo.com>
References: <1634095731-4528-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 12 Oct 2021 20:28:51 -0700, Qing Wang wrote:
> coccicheck complains about the use of snprintf() in sysfs show functions.
> 
> Fix the coccicheck warning:
> WARNING: use scnprintf or sprintf.
> 
> Use sysfs_emit instead of scnprintf or sprintf makes more sense.
> 
> [...]

Applied, thanks!

[1/1] ext4: replace snprintf in show functions with sysfs_emit
      commit: cc5fef71a1c741473eebb1aa6f7056ceb49bc33d

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

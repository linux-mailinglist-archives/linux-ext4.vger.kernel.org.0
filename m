Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D89743E45D
	for <lists+linux-ext4@lfdr.de>; Thu, 28 Oct 2021 16:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbhJ1O7P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Oct 2021 10:59:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39324 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230406AbhJ1O7P (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Oct 2021 10:59:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 19SEudCa003679
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 28 Oct 2021 10:56:40 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4BBF415C00B9; Thu, 28 Oct 2021 10:56:39 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Austin Kim <austindh.kim@gmail.com>, adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        linux-ext4@vger.kernel.org, austin.kim@lge.com
Subject: Re: [PATCH] ext4: remove an unused variable warning with CONFIG_QUOTA=n
Date:   Thu, 28 Oct 2021 10:56:34 -0400
Message-Id: <163543290989.1895911.203055160584231569.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210824034929.GA13415@raspberrypi>
References: <20210824034929.GA13415@raspberrypi>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 24 Aug 2021 04:49:29 +0100, Austin Kim wrote:
> The 'enable_quota' variable is only used in an CONFIG_QUOTA.
> With CONFIG_QUOTA=n, compiler causes a harmless warning:
> 
> fs/ext4/super.c: In function ‘ext4_remount’:
> fs/ext4/super.c:5840:6: warning: variable ‘enable_quota’ set but not used
>   [-Wunused-but-set-variable]
>   int enable_quota = 0;
>               ^~~~~
> 
> [...]

Applied, thanks!

[1/1] ext4: remove an unused variable warning with CONFIG_QUOTA=n
      commit: d94ca0e1d65f4c274e3425a35f23ffe58ecea18a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

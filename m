Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B13A47FA57
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Dec 2021 06:34:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229486AbhL0Fev (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Dec 2021 00:34:51 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:35655 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231690AbhL0Feu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Dec 2021 00:34:50 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BR5YjH6027877
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 27 Dec 2021 00:34:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B51815C3441; Mon, 27 Dec 2021 00:34:45 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/2] ext4: Quota enabling error handling fixes
Date:   Mon, 27 Dec 2021 00:34:41 -0500
Message-Id: <164058326343.3172825.2813128641757517025.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20211007155336.12493-1-jack@suse.cz>
References: <20211007155336.12493-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, 7 Oct 2021 17:53:34 +0200, Jan Kara wrote:
> when enabling of quotas fails in the middle, we could be leaving quota
> subsystem in unexpected state or free inodes with locking classes set.
> Make sure to do proper cleanup in case quota setup fails.
> 
> Honza
> 

Applied, thanks!

[1/2] ext4: Make sure quota gets properly shutdown on error
      commit: 298503cc5015e0512294788127a853a730d47fb1
[2/2] ext4: Make sure to reset inode lockdep class when quota enabling fails
      commit: c5725ba32f98d128d5d83cab6d0b24ceb4ecf731

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

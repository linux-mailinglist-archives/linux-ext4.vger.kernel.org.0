Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F1EE3B1ADF
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Jun 2021 15:13:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230380AbhFWNQH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Jun 2021 09:16:07 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52954 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230206AbhFWNQH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Jun 2021 09:16:07 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15NDDg0Y022614
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Jun 2021 09:13:43 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4420315C3CD6; Wed, 23 Jun 2021 09:13:42 -0400 (EDT)
Date:   Wed, 23 Jun 2021 09:13:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        lishujin@kuaishou.com
Subject: Re: [PATCH V2 1/7] ext4: remove the 'group' parameter of
 ext4_trim_extent
Message-ID: <YNMzhm2gIM2oQfjs@mit.edu>
References: <164ffa3b-c4d5-6967-feba-b972995a6dfb@gmail.com>
 <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61eceb4c-6e5f-34d0-9317-a833d7c63b6f@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jianchao, 

FYI, this patch series has confliects with these patches, which landed
in 5.13-rc1:

196e402adf2e - ext4: improve cr 0 / cr 1 group scanning
4b68f6df1059 - ext4: add MB_NUM_ORDERS macro
a6c75eaf1103 - ext4: add mballoc stats proc file
67d251860461 - ext4: drop s_mb_bal_lock and convert protected fields to atomic

The conflicts were relatively minor, but the obvious fix-ups resulted
in a large number of crashes caused by various stress tests, such as
generic/068 and generic/204.  I'm currently investigating to see what
I might have messed up when I tried applying these patches, as well as
running your patch set applied against 5.12 to make sure the problems
weren't introduced by the patch set itself.

					- Ted

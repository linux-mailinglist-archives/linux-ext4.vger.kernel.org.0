Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40453B8725
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 18:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbhF3Qiu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 12:38:50 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36048 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229622AbhF3Qiu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 12:38:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UGaGDk007162
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:36:17 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5DEC015C3C8E; Wed, 30 Jun 2021 12:36:16 -0400 (EDT)
Date:   Wed, 30 Jun 2021 12:36:16 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/9] ext4/022: exclude this test for dax config on 64KB
 pagesize platform
Message-ID: <YNydgA9OSZWrldaB@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <f956243c84dcc77d8c301d0ec956c68d9076bbcb.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f956243c84dcc77d8c301d0ec956c68d9076bbcb.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:08AM +0530, Ritesh Harjani wrote:
> This test case assumes blocksize to be 4KB and hence it fails
> to mount with "-o dax" option on a 64kb pagesize platform (e.g. PPC64).
> This leads to test case reported as failed with dax config on PPC64.
> 
> This patch exclude this test when pagesize is 64KB and for dax config.
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Looks good, thanks.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>


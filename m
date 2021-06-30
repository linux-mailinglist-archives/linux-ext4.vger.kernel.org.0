Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E67B3B8726
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231704AbhF3QjK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 12:39:10 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36097 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229510AbhF3QjK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Jun 2021 12:39:10 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 15UGaZSi007281
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Jun 2021 12:36:36 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B0C3615C3C8E; Wed, 30 Jun 2021 12:36:35 -0400 (EDT)
Date:   Wed, 30 Jun 2021 12:36:35 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 6/9] gitignore: Add 031.out file to .gitignore
Message-ID: <YNydk5dyn++sql26@mit.edu>
References: <cover.1623651783.git.riteshh@linux.ibm.com>
 <1e987bceb2aca7c38dc375fd68cae0ac12b6d00c.1623651783.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e987bceb2aca7c38dc375fd68cae0ac12b6d00c.1623651783.git.riteshh@linux.ibm.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 14, 2021 at 11:58:10AM +0530, Ritesh Harjani wrote:
> Add 031.out file to .gitignore
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28483EBC9B
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Aug 2021 21:36:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233797AbhHMTg2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Aug 2021 15:36:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42914 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S233794AbhHMTg1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Aug 2021 15:36:27 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 17DJZtDn019303
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Aug 2021 15:35:56 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CA5DD15C37C1; Fri, 13 Aug 2021 15:35:55 -0400 (EDT)
Date:   Fri, 13 Aug 2021 15:35:55 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     djwong@kernel.org
Subject: Re: [PATCH -v4] mke2fs: warn about missing y2038 support when
 formatting fresh ext4 fs
Message-ID: <YRbJmwxd4fRZ+2Rm@mit.edu>
References: <YRbI4E3b42X3otJv@mit.edu>
 <20210813193453.359568-1-tytso@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210813193453.359568-1-tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Oops, I sent the wrong commit; please ignore the -v4 version.

      	     	       	       - Ted

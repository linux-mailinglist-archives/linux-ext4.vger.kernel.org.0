Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7340352F53
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Apr 2021 20:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235419AbhDBScf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Apr 2021 14:32:35 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:36243 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S236452AbhDBScf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Apr 2021 14:32:35 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 132IWKSj020851
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Apr 2021 14:32:20 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 1204215C3ACE; Fri,  2 Apr 2021 14:32:20 -0400 (EDT)
Date:   Fri, 2 Apr 2021 14:32:20 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     paulo.alvarez@tse.jus.br
Cc:     linux-ext4@vger.kernel.org,
        Paulo Antonio Alvarez <pauloaalvarez@gmail.com>
Subject: Re: [PATCH 1/3] Add a Windows implementation of the IO manager
Message-ID: <YGdjNDfSWW6UjHf4@mit.edu>
References: <20201222181552.11267-1-paulo.alvarez@tse.jus.br>
 <20201222181552.11267-2-paulo.alvarez@tse.jus.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201222181552.11267-2-paulo.alvarez@tse.jus.br>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, I've applied this series to e2fsprogs.

	     	     	  	    - Ted

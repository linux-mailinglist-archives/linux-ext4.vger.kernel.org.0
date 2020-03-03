Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B374117741D
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2020 11:26:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgCCK0Q (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Mar 2020 05:26:16 -0500
Received: from mail.acc.umu.se ([130.239.18.156]:45150 "EHLO mail.acc.umu.se"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728473AbgCCK0Q (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Mar 2020 05:26:16 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
        by amavisd-new (Postfix) with ESMTP id 35B1444B97
        for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2020 11:26:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=acc.umu.se; s=mail1;
        t=1583231174; bh=12CAi5DfH8uqnbp0KbvEM4+nnTti3myd+JTgvX1CkLA=;
        h=Date:From:To:Subject:From;
        b=CXf/0jrC4QvCr0NQ7O2wh7gkDzY7RH3I+SdlFAUM9CXRTyC/5kikeY+gXAJcv/cBu
         H36omjCUmbiYNSfjX/NysUsByBkzKn+w/kU+xpZnt9VG8j5IKtV0AgUlGZEQMATffw
         yEqgSKWuX3n/QxXeIqQJqqtAvWjayN2T7n9u7n05Dc6LfZgz+OX5IpoRUCmWIisMnD
         DKokexqxkEp+DM44uAD2HSLWEZ+hn/Bwh9rWRA24ktbVJsa/OHWIbTBaGAk4Quscg8
         h+BTN+TpSgIWXN69iueWrrwnnWLh1MRuO0w33DYiRLbUaOpzpdeLOpIFDmHR7hYYsO
         C6V3PV59t5DzA==
Received: from stalin.acc.umu.se (stalin.acc.umu.se [IPv6:2001:6b0:e:2018::135])
        by mail.acc.umu.se (Postfix) with ESMTP id A1DCC44B93
        for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2020 11:26:13 +0100 (CET)
Received: by stalin.acc.umu.se (Postfix, from userid 10005)
        id 9412C21B1B; Tue,  3 Mar 2020 11:26:13 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by stalin.acc.umu.se (Postfix) with ESMTP id 8E01321B1A
        for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2020 11:26:13 +0100 (CET)
Date:   Tue, 3 Mar 2020 11:26:13 +0100 (CET)
From:   Bo Branten <bosse@acc.umu.se>
To:     linux-ext4@vger.kernel.org
Subject: A question on umounting without flushing journal
Message-ID: <alpine.DEB.2.21.2003031120390.949380@stalin.acc.umu.se>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


Hello,

now I have another question on how to test the ext4 driver we implement 
for another os: At mount time the driver should check the journal and use 
jbd2 to replay if there is anything left in it and I would like to ask if 
there is any other methods to do an unclean umount in linux besides 
pressing reset? I would like to leave a lot of records in the journal that 
our driver can try to process?

Bo Branten


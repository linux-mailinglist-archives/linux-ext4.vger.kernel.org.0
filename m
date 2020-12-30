Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0E322E778B
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Dec 2020 10:50:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgL3Jtj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Dec 2020 04:49:39 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:53656 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgL3Jti (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 30 Dec 2020 04:49:38 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20201230094856epoutp01f34ac45a29f3d5c1715e26386ca989d5~VdZemfTZa2381623816epoutp01x
        for <linux-ext4@vger.kernel.org>; Wed, 30 Dec 2020 09:48:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20201230094856epoutp01f34ac45a29f3d5c1715e26386ca989d5~VdZemfTZa2381623816epoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1609321736;
        bh=v7DGWSbookem4KPaGtataQwzMlNb9nDZ8zNvP4ltbe8=;
        h=Subject:Reply-To:From:To:CC:Date:References:From;
        b=FiX4BG7vZC8hQsi6GeGDJmVFVS2PKKSFKpcww2yoeIO0SHFoDSu/t6iHFo3Dd6LIN
         vD1nLVaKi+Yn04zBKNn+1TTi9taJSH7+kOjORanb4WDIW6O85Va7Qb6U0mGxrRKbxH
         wLdRP3QaKaAQAeFHSD8aheu5RzF+QfbmZrPQZfKw=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20201230094855epcas2p49a103611e30a080fb33c7c422d89d334~VdZeT2Z5g0598105981epcas2p4o;
        Wed, 30 Dec 2020 09:48:55 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.40.186]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4D5RLs3hTcz4x9Q1; Wed, 30 Dec
        2020 09:48:53 +0000 (GMT)
X-AuditID: b6c32a48-4f9ff7000000cd1f-17-5fec4d035a4c
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        35.22.52511.30D4CEF5; Wed, 30 Dec 2020 18:48:51 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH] ext4: Fix wrong list_splice in ext4_fc_cleanup
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From:   Daejun Park <daejun7.park@samsung.com>
To:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a@epcms2p6>
Date:   Wed, 30 Dec 2020 18:48:51 +0900
X-CMS-MailID: 20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrMJsWRmVeSWpSXmKPExsWy7bCmmS6z75t4gz+XxCy+fulgsZg57w6b
        xeVdc9gsWnt+sjuweLRsLvdoOnOU2ePzJrkA5qgGRpvEouSMzLJUhdS85PyUzLx0W6XQEDdd
        CyWFjPziElulaEMLIz1DS1M9E0s9I/NYK0MDAyNTJYW8xNxUW6UKXahuJYWi5AKg6pLU4pKi
        1ORUoFCRQ3FJYnqqXnFibnFpXrpecn6ukkJZYk4pUJ+Svp1NRmpiSmqRQsITxowJ6zcyFzxj
        q2g92s7awPiStYuRg0NCwERi7UujLkYuDiGBHYwS/3uOg8V5BQQl/u4QBjGFBewlfj1L7WLk
        BCpRklh/cRY7iC0soCdx6+EaRhCbTUBHYvqJ+2BxEYEYiaYHOxlBWpkF6iQ+3WUBCUsI8ErM
        aH8KZUtLbF++lRHC1pD4sayXGcIWlbi5+i07jP3+2HyoGhGJ1ntnoWoEJR783A0Vl5Q4tvsD
        E4RdL7H1zi9GkE8kBHoYJQ7vvMUKkdCXuNaxEWwxr4CvxMneG2DNLAKqEnvP7GCChIKLRM8O
        DZAws4C8xPa3c5ghzteUWL9LH6JCWeLILRaICj6JjsN/2WG+2jHvCdQFahLrfq6HGigjcWse
        1JEeEpv6/rFDwi9Q4tK7M0wTGBVmIQJ5FpK1sxDWLmBkXsUollpQnJueWmxUYIIcxZsYwQlR
        y2MH4+y3H/QOMTJxMB5ilOBgVhLhTUh4FS/Em5JYWZValB9fVJqTWnyIsQro34nMUqLJ+cCU
        nFcSb2hmYGRmamxibGxqYkq2sKmRmZmBpamFqZmRhZI4b5HBg3ghgfTEktTs1NSC1CKY5Uwc
        nFINTK1HppiyXbH6Xhm8LaQid1GnquXT7MOx8ele3Z3XvNtUmD9nW85RrT67QeeJUeYCoGq1
        M6dvvN1xcs/qnT2ZecmacS4czLM/x85iTI9bXc0+dWKLxkudpPxJom1GMl+DDtya/kdI+vOf
        L1JRh2cU7lf1v++jLNt39aFEu/N6D517Vf/Cc978Evat1p+xYSaTTtTkJw+1Co+eVLW6mbMu
        Nkx/5sGKZsFf1v/YbmlM5f73nG9btuZKW43eJ0ITdkyLt1AoO//zlkbaljIh0W93F9u/0t+/
        jFuNyUhkg8uB5NQH554uOJVaOo3jW+qhdwvunxR7dVLT6uOui4qmKtyG54In3VNJfXNZmCU4
        UXG+EktxRqKhFnNRcSIA03dwr1YEAAA=
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a
References: <CGME20201230094851epcms2p6eeead8cc984379b37b2efd21af90fd1a@epcms2p6>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

After full/fast commit, entries in staging queue are promoted to main
queue. In ext4_fs_cleanup function, it splice to staging queue to
staging queue.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 fs/ext4/fast_commit.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 4fcc21c25e79..5b6bb3ef0f33 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1268,7 +1268,7 @@ static void ext4_fc_cleanup(journal_t *journal, int full)
 	list_splice_init(&sbi->s_fc_dentry_q[FC_Q_STAGING],
 				&sbi->s_fc_dentry_q[FC_Q_MAIN]);
 	list_splice_init(&sbi->s_fc_q[FC_Q_STAGING],
-				&sbi->s_fc_q[FC_Q_STAGING]);
+				&sbi->s_fc_q[FC_Q_MAIN]);
 
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_COMMITTING);
 	ext4_clear_mount_flag(sb, EXT4_MF_FC_INELIGIBLE);
-- 
2.25.1


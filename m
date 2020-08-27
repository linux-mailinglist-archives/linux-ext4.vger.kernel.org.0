Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1972547FA
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Aug 2020 16:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728327AbgH0O5S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Aug 2020 10:57:18 -0400
Received: from rcdn-iport-5.cisco.com ([173.37.86.76]:35353 "EHLO
        rcdn-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728906AbgH0M0g (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Aug 2020 08:26:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=cisco.com; i=@cisco.com; l=3311; q=dns/txt; s=iport;
  t=1598531194; x=1599740794;
  h=from:to:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=EcnlaDT53itoRiHZXYo2IJ6dB3xRxc9aPXXgN4nxKgs=;
  b=jcSOpVpxYIYajm5SQTbKvKKHHGRvYMMqFjVIYNu/aSSFEVgwhq+++hgb
   /7iZkfyrMvU2/6R4UMsGLsq1uq9l7xC29xVfB+Fn7shWR8bk2UHRK0OT5
   weQdefQBaF7tFGU+SXMXUbelrC+mxDDcTZlqTbXCep3LMNboQe9QlrH07
   s=;
IronPort-PHdr: =?us-ascii?q?9a23=3A16r3RhOOzPq+6z4JNxUl6mtXPHoupqn0MwgJ65?=
 =?us-ascii?q?Eul7NJdOG58o//OFDEvK8z3kHGUJ+d6P9ejefS9af6Vj9I7ZWAtSUEd5pBH1?=
 =?us-ascii?q?8AhN4NlgMtSMiCFQXgLfHsYiB7eaYKVFJs83yhd0QAHsH4ag7MrXCoqz0fAB?=
 =?us-ascii?q?PyMUxyPOumUoLXht68gua1/ZCbag5UhT27NLV1Khj+rQjYusQMx4V4LaNkwR?=
 =?us-ascii?q?rSqXwOcONTlm4=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0A9CACRoUdf/5BdJa1ggQmBSoFSUQe?=
 =?us-ascii?q?BSC8sCodzA6JZhAGBLoElA1ULAQEBDAEBLQIEAQGETAKCQwIkNgcOAgMBAQs?=
 =?us-ascii?q?BAQUBAQECAQYEbYVcAQuGCygGAQEqCgQRAT5CJgEEGxqFUAMuAacsAoE5iBM?=
 =?us-ascii?q?ZNXSBNIMBAQEFhTAYghAJgTiCcYo0G4FBP4FUhx8rg0iCLbZcCoJjBJpKoEU?=
 =?us-ascii?q?tkh+fSwIEAgQFAg4BAQWBWw0mgVdwFYMkUBcCDZIQilZ0NwIGCgEBAwl8jR+?=
 =?us-ascii?q?BNQExXwEB?=
X-IronPort-AV: E=Sophos;i="5.76,359,1592870400"; 
   d="scan'208";a="547523408"
Received: from rcdn-core-8.cisco.com ([173.37.93.144])
  by rcdn-iport-5.cisco.com with ESMTP/TLS/DHE-RSA-SEED-SHA; 27 Aug 2020 12:09:22 +0000
Received: from XCH-RCD-004.cisco.com (xch-rcd-004.cisco.com [173.37.102.14])
        by rcdn-core-8.cisco.com (8.15.2/8.15.2) with ESMTPS id 07RC9Nai020801
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=FAIL)
        for <linux-ext4@vger.kernel.org>; Thu, 27 Aug 2020 12:09:23 GMT
Received: from xhs-aln-002.cisco.com (173.37.135.119) by XCH-RCD-004.cisco.com
 (173.37.102.14) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Aug
 2020 07:09:22 -0500
Received: from xhs-rcd-001.cisco.com (173.37.227.246) by xhs-aln-002.cisco.com
 (173.37.135.119) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 27 Aug
 2020 07:09:22 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (72.163.14.9) by
 xhs-rcd-001.cisco.com (173.37.227.246) with Microsoft SMTP Server (TLS) id
 15.0.1497.2 via Frontend Transport; Thu, 27 Aug 2020 07:09:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2IqW2VZAgzx28c6Un2gkUSXJtveUI91+sXPOR/C7UP1cemU8zcE3CujDlxSjEtZEgM/Vv9exYkLgZyAAAQgP5A0k3xgYcoCNhtSsDeW1YYdVIaaSnK9hZQi25uzmB1WLRdFWNdzYl9eEku3LTdcxU4P3A+oJ3CtXnMxiCPwyHrOPljiIp6qnm0fsa8nSZ6TpMpT7U+C7BcpNgFnc9WHOcgjyWOxbuSQoKj7Og+N5CjmI7TMARbBZRS9vq41/cVXXALXInMuec09ZDG3G1Sjq/4GHzVsNlSAzLTap946AWyF8RgwT9KT4QpcFKIN5yw/nim3qgBJvOVtnR6ZER8Eig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R8Qjve7wrxgdTWoYL36lSDg07LSGwTiO1E3wU88+NI=;
 b=gpGb2CvH3aGasoau9RvifNiKWW8mud5kR98ICVM96SVGsNPpWEOozYfWXUEtwhEUfgEe7NNwkCu8qjdpq98mhzufNkjvcq9qsv78nhoqaeYNiZvMKE5m5YzaFJ+RIy3vT5hWquWnY9an0f5pWzsO8jWiTlRnfP6ixwZ+enm8bwIdyBF+iJBLBhkjNLq0PU1+OHHKbnzjuUx0qfqDAnUgE51v5eYy3Ii7Yld1WrPXW6rgb/lgUe7/HPbPyaskmo8SWZDt1VUBSG/uW2T6vC0+8IVtJhr7gGY6t5jcIvKNpnMoBAdDXUtdmLQTp4x4pUvD48NaINZ915yWCyLTsegltg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=cisco.com; dmarc=pass action=none header.from=cisco.com;
 dkim=pass header.d=cisco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cisco.onmicrosoft.com;
 s=selector2-cisco-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4R8Qjve7wrxgdTWoYL36lSDg07LSGwTiO1E3wU88+NI=;
 b=M1waWTjHNeX5G5mQg2bATIaWAabeakBfttDGyLCiqjYd/sIlMc4XkAkzTAY3VwhryhIBusPpmIHryCAftBxXG8WPkkkWrsGs7ZjTi5HPJf8IaKfRV7Nk8C8y9X2s8G3vAUSglxmLZxOeFOle5hJE2JyR/mr0nmpTrRdiNR4CsW0=
Received: from MN2PR11MB4566.namprd11.prod.outlook.com (2603:10b6:208:24e::16)
 by MN2PR11MB4078.namprd11.prod.outlook.com (2603:10b6:208:150::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 12:09:21 +0000
Received: from MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::d4b9:3010:fa7f:daa0]) by MN2PR11MB4566.namprd11.prod.outlook.com
 ([fe80::d4b9:3010:fa7f:daa0%8]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 12:09:21 +0000
From:   "James Scriven (jamscriv)" <jamscriv@cisco.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Performance issue with recently_deleted() /no_journal with huge
 directories
Thread-Topic: Performance issue with recently_deleted() /no_journal with huge
 directories
Thread-Index: AdZ7xf44aQ/9KhCfRsK81HuuQbbEOg==
Date:   Thu, 27 Aug 2020 12:09:21 +0000
Message-ID: <MN2PR11MB45667C6E534F7944BFA77684DB550@MN2PR11MB4566.namprd11.prod.outlook.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=cisco.com;
x-originating-ip: [135.23.95.23]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1481ab7d-b515-44f0-13b6-08d84a820824
x-ms-traffictypediagnostic: MN2PR11MB4078:
x-microsoft-antispam-prvs: <MN2PR11MB4078A122726A19AA84C751D9DB550@MN2PR11MB4078.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1Hol4e+iBoft8tucbyZf+Gh9XSgiOT/OgEVh/+S3YeQpQ7NRQlUWzPR2APyW3WighZH9ndNkydEvG3cWeG1QTU3VSZZbowHVP5X4YlSacrC+d95hQaHzeradLwGA/kTWMDLcLzlci/Cy21H0MbZ5j15ikZOKZYzcGOUArYIN846rh+k8AwrMUITawfAX6hJR1eI5cviLCX2EhQ1kxkzGyWanRXZA6bccKUGWLPhOSlg8Z5XRKrzwnap9wUsWkPJBjuPpYy1vML8Gl+GFBPIDNKXcspYI8xaxDZ79oc2K2d1KKdtNq+bJuITbmTfjbuiUCJwYRz9hZ8PkXXzcDn1ku5WgHO1Z6ysX9E2GRFUCFiTn7qzlge0Dck00zoDA8ti
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4566.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(39860400002)(396003)(366004)(346002)(6916009)(76116006)(26005)(66556008)(2906002)(6506007)(66946007)(66476007)(64756008)(66446008)(316002)(55016002)(71200400001)(9686003)(186003)(86362001)(52536014)(5660300002)(478600001)(8936002)(7696005)(33656002)(83380400001)(8676002)(14583001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: qT1owo92AbrOAt5APKFz2bIh0M7KkJqqkpYiG3RsXMRNNkoScaWYXrJSPBNYyf6RlKVct7ntbMos3gs6WtHFtQ+ILY7+6E9wIaYrkisRGEiSE9yCUFpLago9GWnqtJDZYkHDgUK5yghLlvPM4xagGluOUuzsbSpZRtvDDTO2+0vOPKjTZYCZKXUPi6Y7Vw6A7iH0Dox0t292AUdqQPbUk4fmetwJ72wYX6zk0pbtk9pX3G8vnlw5IQIYmWd9CkBvtJaT3y2ooNqDQeDg6DtBcWgKxDrISagexEse+eKl4ljzRO9lRKjuDFYhneXyrubCZu7zO1l0z9Z/ArlzZGU+zrvB+MIK4mJDXwvoQMvl7rya13OUdXjNzXNxZX9i+EuK65sXjUcMncqi15V0zXIFt49f18e7reEn3Yhfq3uihv3OztOFyDkT55YQQ7vGSOxVXTlesPRqHSP8jNixq5I0TS4x2sfRe0nkPskg0Qyby3tc6PtqTmMKpgv4AFXW5cfpgEB6X7R7InG6DsN1TXgVjv2A9N7m7eAB7bG4DExjCGwUsTf5aKgBfGNt81NcjdkBfSEs5cSekI2uvVqdXxjqn7raWrb/8kJZKHNmmxdha9mvpiGtKbKtKJyfjblsiSufUw+ZUCMQxjTeaYoxJU6Vkw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4566.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1481ab7d-b515-44f0-13b6-08d84a820824
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Aug 2020 12:09:21.3829
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5ae1af62-9505-4097-a69a-c1553ef7840e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lh0eqS8ZKP74HCnBXEYORJJptgItCzsgm+3s2ik/XPqJ8Afsv1OffnRFchC9NZmZbP0+oQFHaAIIHLYLST5Xog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4078
X-OriginatorOrg: cisco.com
X-Outbound-SMTP-Client: 173.37.102.14, xch-rcd-004.cisco.com
X-Outbound-Node: rcdn-core-8.cisco.com
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi, I'm working on migrating a workload from kernel 2.6 to 4.18 (REHL6 to R=
HEL8).

The use case is a build farm that has a basic workflow of:

1) rm -rf a large directory tree (about 2M files ~ 200GB) to free some spac=
e
2) download and extract a large tarbar (about 2M files ~ 200GB)
3) perform a build in the extracted directory tree
Repeat...

We've being using an ext4 filesystem with no journal for maximum performanc=
e with great success. We're not very concerned about losing data, but do wa=
nt some persistence, which is why we don't just use tmpfs for this. We'll k=
eep a number of these large workspaces around as long as space permits, and=
 delete the oldest (step 1) just before starting a new one (step 2).=20

When migrating to this newer kernel, we are seeing performance degradation =
when we expand the tar, which I suspect is caused by inode allocation tryin=
g to find an unused inode that has not been used too recently. Since we hav=
e 2M deleted inodes that *have* been recently deleted, every one of the new=
 2M inodes has to search through all 2M of the deleted ones (or something t=
o that approximation - my full understanding of the ext4 code is limited).

The simple testcase below shows the issue. My question is, is this edge cas=
e already understood? Is there a good way to re-gain this lost performance?=
 Adding a "sync + drop_caches", or a sufficiently long sleep, between steps=
 1 and 2 will work around the issue, but is not ideal.



# each iteration of the test case the number of recently deleted inodes inc=
reases and performance degrades.

$ uname -a
Linux sjc-asr-bm-470 4.18.0-147.3.1.el8_1.x86_64 #1 SMP Wed Nov 27 01:11:44=
 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux
$ sync; echo 3 | sudo tee /proc/sys/vm/drop_caches; for x in {1..10}; do rm=
 -rf dirtree; mkdir dirtree; time mkdir dirtree/{1..50000}; done
3

real    0m1.796s
user    0m0.041s
sys     0m1.528s

real    0m3.280s
user    0m0.035s
sys     0m3.235s

real    0m4.329s
user    0m0.035s
sys     0m4.279s

real    0m6.033s
user    0m0.032s
sys     0m5.988s

real    0m7.303s
user    0m0.041s
sys     0m7.246s

real    0m7.874s
user    0m0.032s
sys     0m7.826s

real    0m9.376s
user    0m0.036s
sys     0m9.323s

real    0m9.979s
user    0m0.052s
sys     0m9.910s

real    0m9.808s
user    0m0.037s
sys     0m9.749s

real    0m9.067s
user    0m0.038s
sys     0m9.011s




$ uname -a
Linux sjc-asr-bm-100 2.6.32-754.17.1.el6.x86_64 #1 SMP Thu Jun 20 11:47:12 =
EDT 2019 x86_64 x86_64 x86_64 GNU/Linux
$ sync; echo 3 | sudo tee /proc/sys/vm/drop_caches; for x in {1..10}; do rm=
 -rf dirtree; mkdir dirtree; time mkdir dirtree/{1..50000}; done
3

real    0m0.724s
user    0m0.031s
sys     0m0.693s

real    0m0.762s
user    0m0.041s
sys     0m0.721s

real    0m0.717s
user    0m0.043s
sys     0m0.674s

real    0m0.712s
user    0m0.037s
sys     0m0.675s

real    0m0.749s
user    0m0.036s
sys     0m0.712s

real    0m0.710s
user    0m0.040s
sys     0m0.670s

real    0m0.746s
user    0m0.038s
sys     0m0.707s

real    0m0.715s
user    0m0.034s
sys     0m0.680s

real    0m0.747s
user    0m0.040s
sys     0m0.707s

real    0m0.732s
user    0m0.042s
sys     0m0.690s




Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 851933C75CA
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Jul 2021 19:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbhGMRgO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 13 Jul 2021 13:36:14 -0400
Received: from mail-eopbgr60077.outbound.protection.outlook.com ([40.107.6.77]:46721
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229454AbhGMRgO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 13 Jul 2021 13:36:14 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0MrP2CYoLbno14YP5pZJYCG9CYsPgCCAxYidzfx/S7i5P21mDOsQrTK7GOcGJOjy6vs7iEm35bmKVY4O5phgsRxvfVKRvYFOIo/2iQJRMtt9gaiK7QYLovRyFVEC9oGuoo/8CWHwVDNI0kwMUFOHcLOiMCOqMNb9azgzj7oeRRxg6ILDiBFWjDfoer6MDAa+cF/mn9EVW7Hsk5v/9n2Xyee3NcQfVhEbuNQqOkjJ/Gh1wTgeNnv75vkmiQm5VuhergK4OvFOEBFixwxejyQUGwCkfjl6w2y0y14ymulx/LMkwNGfD9aZqENfllmxg+OMMCOlXp/1NyCAIve3kbxTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkjNym2bdTo2xhECHOpWuCOASFUQgHeriMDEFSLJ7NY=;
 b=dupGeOGw1i/JC+IG7IdsdDI1cTjHZlK4w4XEP2z4CMbDXKZp4u3D3haHsotR14XStno9E6xR1c/VAxQWWaFlRY2WMmEnEU/twUm++SXMXi7sVk0UJBhiFl8dT72OY5zGt0qJG1VuhDso98sghWDL6nBbZJSKuHp03GqTbSBFrt0c4OuGatXNqVz0uI31uvNalcXmuaQIvNxp6rHQk5ezcIfDb0gtGeBkr+cCq6oDNTaaREMf7uKk7Hqr4hB0vYqbzJCs4Ua2X2PqqEooPIyheFQ83tQ+lcgagN1VkZOyhBmYt7sHdlg6r+CQ0NRt06Z3Xmk1kSDP7lbd1m6H0hVtXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=urjc.es; dmarc=pass action=none header.from=urjc.es; dkim=pass
 header.d=urjc.es; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=urjc.onmicrosoft.com;
 s=selector2-urjc-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkjNym2bdTo2xhECHOpWuCOASFUQgHeriMDEFSLJ7NY=;
 b=Ft6dnM6gjka/7lQc+XicO6T2HhC9TIMSKlzMFqMGvzMdZxK0/v0kaCVJP6S3hRyh/VIYncS50bFYbSeZNZphFyJ7v5ckrGzmjcCki4Iqi2G7XOenMffK0PxypJUF9Ym0zXEs7MyX+n8iZAVVVdPj+AvePFMqxHASHRkDmN3F3X4=
Authentication-Results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=urjc.es;
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com (2603:10a6:10:5c::15)
 by DB9PR02MB6570.eurprd02.prod.outlook.com (2603:10a6:10:1f8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4331.21; Tue, 13 Jul
 2021 17:33:21 +0000
Received: from DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e]) by DB7PR02MB4663.eurprd02.prod.outlook.com
 ([fe80::1048:a385:a5d8:1f0e%7]) with mapi id 15.20.4308.027; Tue, 13 Jul 2021
 17:33:21 +0000
Date:   Tue, 13 Jul 2021 19:33:19 +0200
From:   Javier Pello <javier.pello@urjc.es>
To:     Jan Kara <jack@suse.cz>
Cc:     Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH 1/1] fs/ext2: Avoid page_address on pages returned by
 ext2_get_page
Message-Id: <20210713193319.a223cd12e3fb8687f0cae0e8@urjc.es>
In-Reply-To: <20210713163018.GF24271@quack2.suse.cz>
References: <20210713165821.8a268e2c1db4fd5cf452acd2@urjc.es>
        <20210713165918.10da0318af5b9b73e599a517@urjc.es>
        <20210713163018.GF24271@quack2.suse.cz>
Organization: Universidad Rey Juan Carlos
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR2P264CA0156.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:1::19) To DB7PR02MB4663.eurprd02.prod.outlook.com
 (2603:10a6:10:5c::15)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from mo-dep2-d036-01.escet.urjc.es (212.128.1.36) by MR2P264CA0156.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:1::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4308.20 via Frontend Transport; Tue, 13 Jul 2021 17:33:20 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c34ea41b-4c10-46ee-e3f8-08d946244efb
X-MS-TrafficTypeDiagnostic: DB9PR02MB6570:
X-Microsoft-Antispam-PRVS: <DB9PR02MB657083F9A710330D2A90E4E79B149@DB9PR02MB6570.eurprd02.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1Ius88t0144PpV5DUOaRrYS/LL6tXDvsu38BZLGSwYQGu3Q7NfS0gK/DT7ub614fkTMH6L2n+7alGUsiL3o/w9JIxDpF0ZTCdVDRhE8vKU0GZN/rxgiEI/yxJJlMNjY+tEFiRpQA4XZQFHt+62Op0MoeLvh/rqkvFJovUF4ffY7Y4Os/pXT/kKOGySyf7OXHB5Gy3NO+AVNhChEXg1r1zUb6W3jpkrJKWiW2PsCa4ztafOKYqmOa7FKcny15XDtUVcbHQ8L6r1SziVxt9j7c/XK3wd73kGtgiTFLcOblOW3jxAIikCFRXaa6hlZjoPE2MaZnoqzBTX4aEHltTjU6iFUztdMV/USXJnxx0CeS00MqLS9OKkWWUzRSiRFRTomRYLQ0rdjYquo8p0Npmg738WKN1P1IgpLEy2xi1+A0G1HfnSg0dQDZ2fT8wxwICgLdeB19kAEtWDSTYFdg9TUgQDep8lRs/DZ1wNkVz2Yiyhfno+21ldMc4p1eKKlFlgl1eNe+ZEt2BFCGOaoFKomLwnm/gIhFuz0bNutVzvnhPki7xG/kYWiRr/PBm2vyVn6QlHY7msqZWA9XRq6aPQf9IzXHzlitCrjvbCd62asp1LwWm6G3oxkX1X2QHu0saRrM8lbznQkNE853PzmHlqJrH+UIFZiEGy4E5zpUt9q5k0osufF4iBNH6/JCrsqU2BdfI5Mk2Q6fSV+6+ZuuQImYHw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR02MB4663.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(39850400004)(396003)(376002)(346002)(136003)(366004)(2906002)(86362001)(8676002)(52116002)(66946007)(44832011)(36916002)(6486002)(7696005)(478600001)(36756003)(66556008)(316002)(26005)(5660300002)(8936002)(66476007)(83380400001)(956004)(786003)(54906003)(4326008)(2616005)(38350700002)(38100700002)(1076003)(186003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jYZ+PmKGSomqponsU03nW1Jp+OJS5waA6fKBEiQizRxQM5elGi+3LqbG7Ncw?=
 =?us-ascii?Q?wX0wd8+GOcs4mMq9qB4CQeRABD9GewK4gPk1sfDK7yJIUDOzcJtIOUaK6lgX?=
 =?us-ascii?Q?I1lLFZBUl9gwbs6ovJ9lhQgKphaX5E9e0TFhUvoBrC5C8RIao9G1hIb0UozH?=
 =?us-ascii?Q?x6y5zh04RS0uKIJ3DqS+XD4BmL1AquhhtDchjCw5WMmU8c2QWSdcDlJXZHyj?=
 =?us-ascii?Q?TIo2/3eiHC1nZSE3Qjr7aLEnvHkK1ic9I4vuBYbb/NCc5VPBNtskEHtDe6+M?=
 =?us-ascii?Q?4Qdfck6O6WJo5Y1hOjDFIji1xec96/qXQuc3X51aIlYTRV2GrKlLbWzFt8Bq?=
 =?us-ascii?Q?FUk4GvYRN87BziM2uFnyAK0KOg4OFPrYbfgH8TtrsfGjMtfiWsKNAsgumgmt?=
 =?us-ascii?Q?V7oIreDbaSkMKmuCd841i6/6CjYEUvphcKkmqvgE/P1CVH5xcFOHolLtQN/o?=
 =?us-ascii?Q?D4zJUoaXCi6RudbDf6VpczlhVJ8jNewuhaMAYH6IKAGJQn6QW8lc3/zZ+JK4?=
 =?us-ascii?Q?cKbzJwz7mCHI7yQslrhguMAHc0FFQFaauddvkshF7gM3JE6cRLAwgBZylkaE?=
 =?us-ascii?Q?uFfINxd5XW0CSRzhrPcwc7QTPOKNYPBcpRoZf5LHkR9GbvZUMpJ/RMwB/AUO?=
 =?us-ascii?Q?EImhvocGMcVjsOu1XmjDKa8+fFdSz9DITbHNU1LBPQtlZRz46nE818dfUo0Q?=
 =?us-ascii?Q?jyPHyu8Zt9/MBnLmeg0SQE7dy3+0xc3O2WPWxA5vDHmS0WLVzn8nsaLsOovj?=
 =?us-ascii?Q?z0rdaRa7kTCXi+VV0xwKdIaK67WHuLDn256ShElLLcl4Z0XquXUI03AKkk+I?=
 =?us-ascii?Q?QQxuhaKXsvGGfAjpgWMc3Zs50ClD22YzYhL9v+z5MM+T30BgbzfVWR5Tpl8X?=
 =?us-ascii?Q?CXCawDzXn0wfKoL60L7C7sxoVkYKV5UQFV9K8tm2+uO4TOVMDx1kmLIeflQZ?=
 =?us-ascii?Q?ACr852N7uUeF1ZYeLholwmnBM0JZYgLTMeWMJXkrB36t5vM9L7b01NAtFyt+?=
 =?us-ascii?Q?q7uxekW5nQoQ1XK+1gZlopMGlfQJk38E9RXovYlOGSqVaBrKcgsc5r0dkSYM?=
 =?us-ascii?Q?wTU6OMGrnas+xQ/4UrzI21lG6CShokLAlotZvk+l/hLjg4rb0sY7HP32og62?=
 =?us-ascii?Q?zovxojADD0vgWO140HqGFBwySks/AMfiJdf+Ys/cYQhDIEeEocYtlX/PzUcx?=
 =?us-ascii?Q?hE5PDWRnzKscwo/Sdv0m3p/B94q1YysiCzXC4FRTtPLqJxg7zD1C9CYzAQD0?=
 =?us-ascii?Q?6o6RGYhUtr6dbZohmibWPyrhYNQsixeRgNZ1VBrLO7IyPNM2z0m8Yu3Hoqe7?=
 =?us-ascii?Q?9t9EBH4hK8RcMXYb/Ia4xCS3?=
X-OriginatorOrg: urjc.es
X-MS-Exchange-CrossTenant-Network-Message-Id: c34ea41b-4c10-46ee-e3f8-08d946244efb
X-MS-Exchange-CrossTenant-AuthSource: DB7PR02MB4663.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2021 17:33:21.2500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5f84c4ea-370d-4b9e-830c-756f8bf1b51f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oz823U/TgMcrVXqsmBxvvvF0w9CCH8EIRfYL6/G/nRjstQUh7hUvE+54DajrP+Xy9n9eZDjFFPS344ivODL0MQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB6570
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 13 Jul 2021 18:30:18, Jan Kara wrote:
> On Tue 13-07-21 16:59:18, Javier Pello wrote:
> > Commit 782b76d7abdf02b12c46ed6f1e9bf715569027f7 ("fs/ext2: Replace
> > kmap() with kmap_local_page()") replaced the kmap/kunmap calls in
> > ext2_get_page/ext2_put_page with kmap_local_page/kunmap_local for
> > efficiency reasons. As a necessary side change, the commit also
> > made ext2_get_page (and ext2_find_entry and ext2_dotdot) return
> > the mapping address along with the page itself, as it is required
> > for kunmap_local, and converted uses of page_address on such pages
> > to use the newly returned address instead. However, uses of
> > page_address on such pages were missed in ext2_check_page and
> > ext2_delete_entry, which triggers oopses if kmap_local_page happens
> > to return an address from high memory. Fix this now by converting
> > the remaining uses of page_address to use the right address, as
> > returned by kmap_local_page.
> 
> Good catch. Thanks for the patch. Ira, can you please check the patch as
> well?
> 
> I have just a few nits below:
> 
> > Signed-off-by: Javier Pello <javier.pello@urjc.es>
> > Fixes: 782b76d7abdf fs/ext2: Replace kmap() with kmap_local_page()
> 
> Please wrap subject in Fixes tag into ("...").

Will do.

> > @@ -584,16 +584,16 @@ int ext2_add_link (struct dentry *dentry, struct inode *inode)
> >   * ext2_delete_entry deletes a directory entry by merging it with the
> >   * previous entry. Page is up-to-date.
> >   */
> > -int ext2_delete_entry (struct ext2_dir_entry_2 * dir, struct page * page )
> > +int ext2_delete_entry (struct ext2_dir_entry_2 *dir, struct page *page,
> > +                     void *kaddr)
> 
> Why not have 'kaddr' as char *. We type it to char * basically everywhere
> anyway.

I thought about that, as well, but in the end I leaned towards void *
because it is a generic pointer, conceptually. Would you rather have it
be char *?

> >  {
> >       struct inode *inode = page->mapping->host;
> > -     char *kaddr = page_address(page);
> > -     unsigned from = ((char*)dir - kaddr) & ~(ext2_chunk_size(inode)-1);
> > -     unsigned to = ((char *)dir - kaddr) +
> > -                             ext2_rec_len_from_disk(dir->rec_len);
> > +     unsigned int delta = (char *)dir - (char *)kaddr;
> 
> Maybe I'd call this 'offset' rather than 'delta'.

Fair enough.

> Also if kaddr will stay
> char *, you maybe just don't need to touch this...

Yes, if kaddr becomes char * then there is no need to touch these lines.

Javier
